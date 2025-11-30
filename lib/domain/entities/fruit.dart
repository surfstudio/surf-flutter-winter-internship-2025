import 'package:equatable/equatable.dart';

import 'nutrition.dart';

class Fruit extends Equatable {
  const Fruit({
    required this.id,
    required this.name,
    required this.family,
    required this.order,
    required this.genus,
    required this.nutritions,
    this.isFavorite = false,
  });

  final int id;
  final String name;
  final String family;
  final String order;
  final String genus;
  final Nutrition nutritions;
  final bool isFavorite;

  Fruit copyWith({
    int? id,
    String? name,
    String? family,
    String? order,
    String? genus,
    Nutrition? nutritions,
    bool? isFavorite,
  }) {
    return Fruit(
      id: id ?? this.id,
      name: name ?? this.name,
      family: family ?? this.family,
      order: order ?? this.order,
      genus: genus ?? this.genus,
      nutritions: nutritions ?? this.nutritions,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props =>
      [
        id,
        name,
        family,
        order,
        genus,
        nutritions,
        isFavorite,
      ];

  @override
  String toString() {
    return 'Fruit(id: $id, name: $name, family: $family, nutritions: $nutritions, isFavorite: $isFavorite)';
  }
}