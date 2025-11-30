import '../entities/fruit.dart';

abstract interface class IFruitsRepository {
  Future<List<Fruit>> getAllFruits ();
}