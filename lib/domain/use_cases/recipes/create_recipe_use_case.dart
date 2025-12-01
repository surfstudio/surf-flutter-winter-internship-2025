import 'package:surf_flutter_winter_internship_2025/domain/entities/recipe.dart';
import 'package:surf_flutter_winter_internship_2025/domain/repositories/i_recipe_repository.dart';

import 'interfaces/i_create_recipe_use_case.dart';

class CreateRecipeUseCase implements ICreateRecipeUseCase {
  final IRecipeRepository _recipeRepository;

  const CreateRecipeUseCase({required IRecipeRepository recipeRepository})
      : _recipeRepository = recipeRepository;

  @override
  Future<void> call(Recipe recipe) async {
    await _recipeRepository.saveRecipe(recipe);
  }
}