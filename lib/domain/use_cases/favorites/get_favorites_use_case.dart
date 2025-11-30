import 'package:surf_flutter_winter_internship_2025/domain/entities/fruit.dart';
import 'package:surf_flutter_winter_internship_2025/domain/repositories/i_favorites_repository.dart';


class GetFavoritesUseCase {
  final IFavoritesRepository _favoritesRepository;

  GetFavoritesUseCase(this._favoritesRepository);

  Future<List<Fruit>> call() async {
    return await _favoritesRepository.getFavoriteFruits();
  }
}