class SortOption {
  final String title;
  final SortType type;
  final SortDirection direction;

  const SortOption({
    required this.title,
    required this.type,
    required this.direction,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is SortOption &&
              runtimeType == other.runtimeType &&
              title == other.title &&
              type == other.type &&
              direction == other.direction;

  @override
  int get hashCode => title.hashCode ^ type.hashCode ^ direction.hashCode;

  SortOption copyWith({
    String? title,
    SortType? type,
    SortDirection? direction,
  }) {
    return SortOption(
      title: title ?? this.title,
      type: type ?? this.type,
      direction: direction ?? this.direction,
    );
  }
}



enum SortType {
  name,
  calories,
}

enum SortDirection {
  ascending,
  descending,
}

