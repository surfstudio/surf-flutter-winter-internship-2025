import 'package:surf_flutter_winter_internship_2025/domain/entities/filter_option.dart';

class UIFilterOption {
  final String title;
  final String description;
  final FilterType type;
  final bool isSelected;

  const UIFilterOption({
    required this.title,
    required this.description,
    required this.type,
    this.isSelected = false,
  });

  UIFilterOption copyWith({
    String? title,
    String? description,
    FilterType? type,
    bool? isSelected,
  }) {
    return UIFilterOption(
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}