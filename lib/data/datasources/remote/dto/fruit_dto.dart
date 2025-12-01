import 'package:json_annotation/json_annotation.dart';
import 'nutrition_dto.dart';

part 'fruit_dto.g.dart';

@JsonSerializable()
class FruitDto {
  final int id;
  final String genus;
  final String name;
  final String family;
  final String order;
  final NutritionDto nutritions;

  FruitDto({
    required this.id,
    required this.genus,
    required this.name,
    required this.family,
    required this.order,
    required this.nutritions,
  });

  factory FruitDto.fromJson(Map<String, dynamic> json) =>
      _$FruitDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FruitDtoToJson(this);

  @override
  String toString() {
    return 'FruitModel(id: $id, name: $name, family: $family)';
  }
}