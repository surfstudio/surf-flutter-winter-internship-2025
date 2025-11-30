import 'package:flutter/foundation.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/fruit.dart';

abstract class IFruitDetailVM with ChangeNotifier {
  Fruit get fruit;

  bool get isLoading;

  String? get error;

  bool get hasError;

  Future<void> onFavoriteTap();
}
