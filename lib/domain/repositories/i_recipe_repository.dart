import 'package:surf_flutter_winter_internship_2025/domain/entities/recipe.dart';

abstract interface class IRecipeRepository {
  Future<void> saveRecipe(Recipe recipe);

  Future<void> deleteRecipe(String recipeId);

  Future<List<Recipe>> getRecipes();

  Future<Recipe?> getRecipeById(String recipeId);
}
