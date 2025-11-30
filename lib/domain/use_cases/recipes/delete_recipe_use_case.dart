import 'package:surf_flutter_winter_internship_2025/domain/repositories/i_recipe_repository.dart';

class DeleteRecipeUseCase {
  final IRecipeRepository _recipeRepository;

  const DeleteRecipeUseCase({required IRecipeRepository recipeRepository})
      : _recipeRepository = recipeRepository;

  Future<void> call(String recipeId) async {
    await _recipeRepository.deleteRecipe(recipeId);
  }
}