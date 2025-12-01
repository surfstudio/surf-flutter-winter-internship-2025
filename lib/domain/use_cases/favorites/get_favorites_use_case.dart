import 'package:surf_flutter_winter_internship_2025/domain/entities/fruit.dart';
import 'package:surf_flutter_winter_internship_2025/domain/repositories/i_favorites_repository.dart';

import 'interfaces/i_get_favorites_use_case.dart';


class GetFavoritesUseCase implements IGetFavoritesUseCase {
  final IFavoritesRepository _favoritesRepository;

  GetFavoritesUseCase(this._favoritesRepository);

  Future<List<Fruit>> call() async {
    return await _favoritesRepository.getFavoriteFruits();
  }
}