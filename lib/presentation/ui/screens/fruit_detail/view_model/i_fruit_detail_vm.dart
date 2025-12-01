import 'package:flutter/material.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/ui_models/ui_fruit.dart';

abstract interface class IFruitDetailVM with ChangeNotifier {
  UIFruit get fruit;
  bool get isLoading;
  bool get hasError;
  String? get error;

  Future<void> onFavoriteTap();
  void dispose();
}