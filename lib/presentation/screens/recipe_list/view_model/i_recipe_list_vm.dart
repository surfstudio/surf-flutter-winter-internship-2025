import 'package:flutter/material.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/recipe.dart';

abstract class IRecipeListVM with ChangeNotifier {
  List<Recipe> get recipes;
  bool get isLoading;
  String? get error;
  bool get hasError;

  Future<void> loadRecipes();
  void retry();
  void onCreateRecipeTap(BuildContext context);
  Future<void> onDeleteRecipeTap(Recipe recipe);
}