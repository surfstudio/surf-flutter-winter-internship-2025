import 'package:surf_flutter_winter_internship_2025/domain/repositories/i_favorites_repository.dart';

import 'interfaces/i_watch_favorites_use_case.dart';

class WatchFavoritesUseCase implements IWatchFavoritesUseCase {
  final IFavoritesRepository _favoritesRepository;

  WatchFavoritesUseCase(this._favoritesRepository);

  Stream<Set<int>> call() {
    return _favoritesRepository.watchFavoriteIds();
  }
}