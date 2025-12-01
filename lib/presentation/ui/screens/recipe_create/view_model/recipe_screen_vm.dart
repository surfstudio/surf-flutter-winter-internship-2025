import 'package:flutter/material.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/fruit.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/nutrition.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/recipe.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/fruits/interfaces/i_get_fruits_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/recipes/interfaces/i_create_recipe_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/mappers/ui_fruit_mapper.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/ui_models/ui_fruit.dart';

import 'i_recipe_create_vm.dart';

class RecipeCreateVM with ChangeNotifier implements IRecipeCreateVM {
  final IGetFruitsUseCase _getFruitsUseCase;
  final ICreateRecipeUseCase _createRecipeUseCase;
  final UIFruitMapper _uiFruitMapper;

  RecipeCreateVM({
    required IGetFruitsUseCase getFruitsUseCase,
    required ICreateRecipeUseCase createRecipeUseCase,
    required UIFruitMapper uiFruitMapper,
  })  : _getFruitsUseCase = getFruitsUseCase,
        _createRecipeUseCase = createRecipeUseCase,
        _uiFruitMapper = uiFruitMapper {
    loadAvailableFruits();
  }

  List<Fruit> _availableFruitsEntities = [];
  final List<Fruit> _selectedFruitsEntities = [];
  String _recipeName = '';
  String _recipeDescription = '';
  bool _isLoading = false;
  String? _error;

  @override
  List<UIFruit> get availableFruits => _uiFruitMapper.toUIList(
    _availableFruitsEntities,
    favoriteIds: const [],
  );

  @override
  List<UIFruit> get selectedFruits => _uiFruitMapper.toUIList(
    _selectedFruitsEntities,
    favoriteIds: const [],
  );

  @override
  String get recipeName => _recipeName;

  @override
  String get recipeDescription => _recipeDescription;

  @override
  bool get isLoading => _isLoading;

  @override
  String? get error => _error;

  @override
  bool get hasError => error != null;

  @override
  bool get canCreateRecipe =>
      _recipeName.trim().isNotEmpty &&
          _selectedFruitsEntities.isNotEmpty &&
          !_isLoading;

  @override
  void onRecipeNameChanged(String name) {
    _recipeName = name;
    notifyListeners();
  }

  @override
  void onRecipeDescriptionChanged(String description) {
    _recipeDescription = description;
    notifyListeners();
  }

  @override
  void onFruitSelected(UIFruit fruit) {
    final entityFruit = _availableFruitsEntities.firstWhere(
          (element) => element.id == fruit.id,
    );
    _selectedFruitsEntities.add(entityFruit);
    notifyListeners();
  }

  @override
  void onFruitDeselected(UIFruit fruit) {
    _selectedFruitsEntities.removeWhere((element) => element.id == fruit.id);
    notifyListeners();
  }

  @override
  Future<void> loadAvailableFruits() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _availableFruitsEntities = await _getFruitsUseCase();
    } catch (e) {
      _error = 'Failed to load available fruits';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  Future<void> createRecipe() async {
    if (!canCreateRecipe) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final totalNutrition = _calculateTotalNutrition();

      final recipe = Recipe(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _recipeName.trim(),
        description: _recipeDescription.trim(),
        fruits: _selectedFruitsEntities,
        createdAt: DateTime.now(),
      );

      await _createRecipeUseCase(recipe);

      _resetForm();
    } catch (e) {
      _error = 'Failed to create recipe';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _resetForm() {
    _recipeName = '';
    _recipeDescription = '';
    _selectedFruitsEntities.clear();
    _error = null;
  }

  // TODO: Extract
  Nutrition _calculateTotalNutrition() {
    double calories = 0;
    double fat = 0;
    double sugar = 0;
    double carbohydrates = 0;
    double protein = 0;

    for (final fruit in _selectedFruitsEntities) {
      final nutrition = fruit.nutritions;
      calories += nutrition.calories;
      fat += nutrition.fat;
      sugar += nutrition.sugar;
      carbohydrates += nutrition.carbohydrates;
      protein += nutrition.protein;
    }

    return Nutrition(
      calories: calories,
      fat: fat,
      sugar: sugar,
      carbohydrates: carbohydrates,
      protein: protein,
    );
  }
}