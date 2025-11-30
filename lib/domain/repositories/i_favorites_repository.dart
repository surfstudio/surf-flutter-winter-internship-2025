import 'package:surf_flutter_winter_internship_2025/domain/entities/fruit.dart';

abstract interface class IFavoritesRepository {

  Future<void> addFavorite(Fruit fruit);

  Future<void> removeFavorite(Fruit fruit);

  Future<bool> isFavorite(Fruit fruit);

  Future<void> toggleFavorite(Fruit fruit);

  Stream<Set<int>> watchFavoriteIds();

  Future<List<int>> getFavoriteIds();

  Future<List<Fruit>> getFavoriteFruits();
}