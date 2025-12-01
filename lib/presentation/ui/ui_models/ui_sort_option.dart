import 'package:surf_flutter_winter_internship_2025/domain/entities/sort_option.dart';

class UISortOption {
  final String title;
  final SortType type;
  final SortDirection direction;
  final bool isSelected;

  const UISortOption({
    required this.title,
    required this.type,
    required this.direction,
    this.isSelected = false,
  });

  UISortOption copyWith({
    String? title,
    SortType? type,
    SortDirection? direction,
    bool? isSelected,
  }) {
    return UISortOption(
      title: title ?? this.title,
      type: type ?? this.type,
      direction: direction ?? this.direction,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}