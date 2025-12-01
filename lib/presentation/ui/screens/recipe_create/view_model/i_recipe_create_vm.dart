import 'package:flutter/material.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/ui_models/ui_fruit.dart';

abstract interface class IRecipeCreateVM with ChangeNotifier {
  List<UIFruit> get availableFruits;
  List<UIFruit> get selectedFruits;
  String get recipeName;
  String get recipeDescription;
  bool get isLoading;
  String? get error;
  bool get hasError;
  bool get canCreateRecipe;

  void onRecipeNameChanged(String name);
  void onRecipeDescriptionChanged(String description);
  void onFruitSelected(UIFruit fruit);
  void onFruitDeselected(UIFruit fruit);
  Future<void> loadAvailableFruits();
  Future<void> createRecipe();
}