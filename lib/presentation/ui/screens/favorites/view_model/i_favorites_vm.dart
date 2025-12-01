import 'package:flutter/material.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/ui_models/ui_fruit.dart';

abstract interface class IFavoritesVM with ChangeNotifier {
  List<UIFruit> get fruits;
  bool get isLoading;
  String? get error;
  bool get hasError;
  bool get isEmpty;

  Future<void> loadFavorites();
  void onCardTap(BuildContext context, UIFruit fruit);
  Future<void> onFavoriteTap(UIFruit fruit);
  void retry();
  void dispose();
}