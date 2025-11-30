class FilterOption {
  final String title;
  final String description;
  final FilterType type;
  final bool isSelected;

  const FilterOption({
    required this.title,
    required this.description,
    required this.type,
    this.isSelected = false,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is FilterOption &&
              runtimeType == other.runtimeType &&
              title == other.title &&
              description == other.description &&
              type == other.type &&
              isSelected == other.isSelected;

  @override
  int get hashCode =>
      title.hashCode ^ description.hashCode ^ type.hashCode ^ isSelected.hashCode;

  FilterOption copyWith({
    String? title,
    String? description,
    FilterType? type,
    bool? isSelected,
  }) {
    return FilterOption(
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

enum FilterType {
  breakfast,
  training,
  diet,
  snack,
  satiety
}