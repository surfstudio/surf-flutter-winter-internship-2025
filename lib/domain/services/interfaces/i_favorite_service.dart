abstract class IFavoritesService {
  Stream<Set<int>> get favoritesStream;

  Set<int> get currentFavoriteIds;

  bool isFavorite(int fruitId);

  void dispose();
}
