import 'package:flutter/material.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/ui_models/ui_recipe.dart';

abstract interface class IRecipeListVM with ChangeNotifier {
  List<UIRecipe> get recipes;
  bool get isLoading;
  String? get error;
  bool get hasError;

  Future<void> loadRecipes();
  void onCreateRecipeTap(BuildContext context);
  Future<void> onDeleteRecipeTap(UIRecipe recipe);
  void retry();
}