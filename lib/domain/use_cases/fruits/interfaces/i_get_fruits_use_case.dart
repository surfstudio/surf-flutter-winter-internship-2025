import 'package:surf_flutter_winter_internship_2025/domain/entities/fruit.dart';

abstract interface class IGetFruitsUseCase {
  Future<List<Fruit>> call();
}