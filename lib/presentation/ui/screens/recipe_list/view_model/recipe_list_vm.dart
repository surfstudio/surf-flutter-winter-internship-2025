import 'package:flutter/material.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/recipe.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/recipes/interfaces/i_delete_recipe_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/recipes/interfaces/i_get_recipe_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/mappers/ui_recipe_mapper.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/navigation/main_navigation.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/screens/recipe_create/recipe_create_screen_builder.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/ui_models/ui_recipe.dart';

import 'i_recipe_list_vm.dart';

class RecipeListVM with ChangeNotifier implements IRecipeListVM {
  final IGetRecipesUseCase _getRecipesUseCase;
  final IDeleteRecipeUseCase _deleteRecipeUseCase;
  final UIRecipeMapper _uiRecipeMapper;

  RecipeListVM({
    required IGetRecipesUseCase getRecipesUseCase,
    required IDeleteRecipeUseCase deleteRecipeUseCase,
    required UIRecipeMapper uiRecipeMapper,
  })  : _getRecipesUseCase = getRecipesUseCase,
        _deleteRecipeUseCase = deleteRecipeUseCase,
        _uiRecipeMapper = uiRecipeMapper {
    _loadRecipesOnInit();
  }

  void _loadRecipesOnInit() {
    loadRecipes();
  }

  List<Recipe> _recipes = [];
  bool _isLoading = false;
  String? _error;

  @override
  List<UIRecipe> get recipes => _uiRecipeMapper.toUIList(_recipes);

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
  Future<void> onCreateRecipeTap(BuildContext context) async {
    await MainNavigation.push(context, const RecipeCreateScreenBuilder());
    await loadRecipes();
  }

  @override
  Future<void> onDeleteRecipeTap(UIRecipe recipe) async {
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