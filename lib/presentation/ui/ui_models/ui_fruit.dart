import 'package:surf_flutter_winter_internship_2025/presentation/ui/ui_models/ui_nutrition.dart';

class UIFruit {
  final int id;
  final String name;
  final String family;
  final String order;
  final String genus;
  final UINutrition nutritions;
  final bool isFavorite;

  const UIFruit({
    required this.id,
    required this.name,
    required this.family,
    required this.order,
    required this.genus,
    required this.nutritions,
    required this.isFavorite,
  });

  UIFruit copyWith({
    int? id,
    String? name,
    String? family,
    String? order,
    String? genus,
    UINutrition? nutritions,
    bool? isFavorite,
  }) {
    return UIFruit(
      id: id ?? this.id,
      name: name ?? this.name,
      family: family ?? this.family,
      order: order ?? this.order,
      genus: genus ?? this.genus,
      nutritions: nutritions ?? this.nutritions,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}