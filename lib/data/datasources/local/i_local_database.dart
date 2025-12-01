abstract interface class ILocalDataBase {
  Future<List<Map<String, dynamic>>> getFavoriteFruits();
  Future<void> addFavorite(Map<String, dynamic> fruitMap);
  Future<void> removeFavorite(int fruitId);

  Future<List<Map<String, dynamic>>> getRecipes();
  Future<void> saveRecipe(Map<String, dynamic> recipe);
  Future<void> deleteRecipe(String recipeId);
}
