import 'package:surf_flutter_winter_internship_2025/domain/entities/fruit.dart';
import 'package:surf_flutter_winter_internship_2025/domain/repositories/i_fruits_repository.dart';

class GetFruitsUseCase {
  final IFruitsRepository _repository;

  GetFruitsUseCase(this._repository);

  Future<List<Fruit>> call() async {
    return await _repository.getAllFruits();
  }
}