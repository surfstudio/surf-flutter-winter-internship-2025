import 'dart:async';

import 'package:surf_flutter_winter_internship_2025/data/datasources/local_datasource.dart';
import 'package:surf_flutter_winter_internship_2025/data/mappers/fruit_local_mapper.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/fruit.dart';
import 'package:surf_flutter_winter_internship_2025/domain/repositories/i_favorites_repository.dart';

import 'base_local_repository.dart';

final class FavoritesRepository extends BaseLocalRepository implements IFavoritesRepository {
  final LocalDataSource _localDataSource;
  final FruitLocalMapper _fruitLocalMapper;
  final StreamController<Set<int>> _controller = StreamController<Set<int>>.broadcast();

  FavoritesRepository({required localDataSource, required fruitLocalMapper})
      : _localDataSource = localDataSource,
        _fruitLocalMapper = fruitLocalMapper;

  @override
  Future<void> addFavorite(Fruit fruit) async {
    return handleLocalException(() async {
      final fruitMap = _fruitLocalMapper.toStorageModel(fruit);
      await _localDataSource.addFavorite(fruitMap);
      _notifyListeners();
    });
  }

  @override
  Future<void> removeFavorite(Fruit fruit) async {
    return handleLocalException(() async {
      await _localDataSource.removeFavorite(fruit.id);
      _notifyListeners();
    });
  }

  @override
  Future<bool> isFavorite(Fruit fruit) async {
    return handleLocalException(() async {
      final favoriteIds = await getFavoriteIds();
      return favoriteIds.contains(fruit.id);
    });
  }

  @override
  Future<void> toggleFavorite(Fruit fruit) async {
    return handleLocalException(() async {
      if (await isFavorite(fruit)) {
        await removeFavorite(fruit);
      } else {
        await addFavorite(fruit);
      }
    });
  }

  @override
  Stream<Set<int>> watchFavoriteIds() {
    _notifyListeners();
    return _controller.stream;
  }

  void _notifyListeners() async {
    try {
      final favoriteIds = await getFavoriteIds();
      _controller.add(favoriteIds.toSet());
    } catch (_) {}
  }

  void dispose() {
    _controller.close();
  }

  @override
  Future<List<int>> getFavoriteIds() async {
    return handleLocalException(() async {
      final maps = await _localDataSource.getFavoriteFruits();
      return maps.map((map) => map['fruit_id'] as int).toList();
    });
  }

  @override
  Future<List<Fruit>> getFavoriteFruits() async {
    return handleLocalException(() async {
      final maps = await _localDataSource.getFavoriteFruits();
      return _fruitLocalMapper.toEntityList(maps);
    });
  }
}