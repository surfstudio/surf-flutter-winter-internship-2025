import 'package:surf_flutter_winter_internship_2025/domain/entities/fruit.dart';
import 'package:surf_flutter_winter_internship_2025/domain/repositories/i_fruits_repository.dart';

import 'interfaces/i_get_fruits_use_case.dart';

class GetFruitsUseCase implements IGetFruitsUseCase {
  final IFruitsRepository _repository;

  GetFruitsUseCase(this._repository);

  Future<List<Fruit>> call() async {
    return await _repository.getAllFruits();
  }
}