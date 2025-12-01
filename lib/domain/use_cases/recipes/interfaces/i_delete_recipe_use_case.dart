abstract interface class IDeleteRecipeUseCase {
  Future<void> call(String recipeId);
}