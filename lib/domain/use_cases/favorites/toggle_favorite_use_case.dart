import 'package:surf_flutter_winter_internship_2025/domain/entities/fruit.dart';
import 'package:surf_flutter_winter_internship_2025/domain/repositories/i_favorites_repository.dart';

import 'interfaces/i_toggle_favorite_use_case.dart';

class ToggleFavoriteUseCase implements IToggleFavoriteUseCase {
  final IFavoritesRepository _favoriteRepository;

  ToggleFavoriteUseCase({required IFavoritesRepository favoriteRepository})
    : _favoriteRepository = favoriteRepository;

  Future<void> call(Fruit fruit) async {
    final isCurrentlyFavorite = await _favoriteRepository.isFavorite(fruit);

    if (isCurrentlyFavorite) {
      await _favoriteRepository.removeFavorite(fruit);
    } else {
      await _favoriteRepository.addFavorite(fruit);
    }
  }
}
