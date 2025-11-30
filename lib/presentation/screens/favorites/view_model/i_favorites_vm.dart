import 'package:flutter/material.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/fruit.dart';

abstract class IFavoritesVM with ChangeNotifier {
  List<Fruit> get fruits;

  bool get isLoading;

  bool get isEmpty;

  String? get error;

  bool get hasError;

  void retry();

  void dispose();

  void onCardTap(BuildContext context, Fruit fruit);

  Future<void> loadFavorites();

  Future<void> onFavoriteTap(Fruit fruit);
}