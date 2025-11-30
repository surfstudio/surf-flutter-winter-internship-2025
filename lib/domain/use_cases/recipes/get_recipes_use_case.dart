import 'package:surf_flutter_winter_internship_2025/domain/entities/recipe.dart';
import 'package:surf_flutter_winter_internship_2025/domain/repositories/i_recipe_repository.dart';

class GetRecipesUseCase {
  final IRecipeRepository _recipeRepository;

  const GetRecipesUseCase({required IRecipeRepository recipeRepository})
      : _recipeRepository = recipeRepository;

  Future<List<Recipe>> call() async {
    return await _recipeRepository.getRecipes();
  }
}