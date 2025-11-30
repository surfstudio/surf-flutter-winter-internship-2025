import 'package:flutter/material.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/recipe.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/recipes/delete_recipe_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/recipes/get_recipes_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/screens/recipe_list/view_model/i_recipe_list_vm.dart';

class RecipeListVM with ChangeNotifier implements IRecipeListVM {
  final GetRecipesUseCase _getRecipesUseCase;
  final DeleteRecipeUseCase _deleteRecipeUseCase;

  RecipeListVM({
    required GetRecipesUseCase getRecipesUseCase,
    required DeleteRecipeUseCase deleteRecipeUseCase,
  })  : _getRecipesUseCase = getRecipesUseCase,
        _deleteRecipeUseCase = deleteRecipeUseCase {
    _loadRecipesOnInit();
  }

  void _loadRecipesOnInit() {
    loadRecipes();
  }

  List<Recipe> _recipes = [];
  bool _isLoading = false;
  String? _error;

  @override
  List<Recipe> get recipes => _recipes;

  @override
  bool get isLoading => _isLoading;

  @override
  String? get error => _error;

  @override
  bool get hasError => error != null;

  @override
  Future<void> loadRecipes() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _recipes = await _getRecipesUseCase();
    } catch (e) {
      _error = 'Failed to load recipes';
      _recipes = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void onCreateRecipeTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold()//const RecipeCreateScreenBuilder(),
      ),
    ).then((_) {
      loadRecipes();
    });
  }

  @override
  Future<void> onDeleteRecipeTap(Recipe recipe) async {
    try {
      await _deleteRecipeUseCase(recipe.id);
      await loadRecipes();
    } catch (e) {
      _error = 'Failed to delete recipe';
      notifyListeners();
    }
  }

  @override
  void retry() {
    loadRecipes();
  }
}