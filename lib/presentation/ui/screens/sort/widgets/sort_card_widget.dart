import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_flutter_winter_internship_2025/assets/app_strings.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/sort_option.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/screens/sort/view_model/i_sort_screen_vm.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/ui_models/ui_sort_option.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/uikit/colors/app_colors.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/uikit/text_styles/app_text_styles.dart';

// TODO: REFACT

class SortCardWidget extends StatelessWidget {
  const SortCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ISortScreenVM>();

    return Card(
      color: AppColors.card,
      elevation: 4,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _SortCategoriesWidget(
              sortOptions: vm.sortOptions,
              selectedSort: vm.selectedSort,
            ),
          ],
        ),
      ),
    );
  }
}

class _SortCategoriesWidget extends StatelessWidget {
  final List<UISortOption> sortOptions;
  final UISortOption? selectedSort;

  const _SortCategoriesWidget({
    required this.sortOptions,
    required this.selectedSort,
  });

  @override
  Widget build(BuildContext context) {
    final vm = context.read<ISortScreenVM>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.sort,
          style: AppTextStyles.titleMedium,
        ),
        const SizedBox(height: 10),
        _NameAscendingSortWidget(
          sort: _findSortOption(SortType.name, SortDirection.ascending),
          isSelected: _isSortSelected(SortType.name, SortDirection.ascending),
          onTap: () => vm.selectSort(_findSortOption(SortType.name, SortDirection.ascending)),
        ),
        const SizedBox(height: 12),
        _NameDescendingSortWidget(
          sort: _findSortOption(SortType.name, SortDirection.descending),
          isSelected: _isSortSelected(SortType.name, SortDirection.descending),
          onTap: () => vm.selectSort(_findSortOption(SortType.name, SortDirection.descending)),
        ),
        const SizedBox(height: 12),
        _CaloriesAscendingSortWidget(
          sort: _findSortOption(SortType.calories, SortDirection.ascending),
          isSelected: _isSortSelected(SortType.calories, SortDirection.ascending),
          onTap: () => vm.selectSort(_findSortOption(SortType.calories, SortDirection.ascending)),
        ),
        const SizedBox(height: 12),
        _CaloriesDescendingSortWidget(
          sort: _findSortOption(SortType.calories, SortDirection.descending),
          isSelected: _isSortSelected(SortType.calories, SortDirection.descending),
          onTap: () => vm.selectSort(_findSortOption(SortType.calories, SortDirection.descending)),
        ),
      ],
    );
  }

  bool _isSortSelected(SortType type, SortDirection direction) {
    return selectedSort != null &&
        selectedSort!.type == type &&
        selectedSort!.direction == direction;
  }

  UISortOption _findSortOption(SortType type, SortDirection direction) {
    return sortOptions.firstWhere(
          (sort) => sort.type == type && sort.direction == direction,
    );
  }
}

class _NameAscendingSortWidget extends StatelessWidget {
  final UISortOption sort;
  final bool isSelected;
  final VoidCallback onTap;

  const _NameAscendingSortWidget({
    required this.sort,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return _SortCategoryRowWidget(
      sort: sort,
      isSelected: isSelected,
      onTap: onTap,
    );
  }
}

class _NameDescendingSortWidget extends StatelessWidget {
  final UISortOption sort;
  final bool isSelected;
  final VoidCallback onTap;

  const _NameDescendingSortWidget({
    required this.sort,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return _SortCategoryRowWidget(
      sort: sort,
      isSelected: isSelected,
      onTap: onTap,
    );
  }
}

class _CaloriesAscendingSortWidget extends StatelessWidget {
  final UISortOption sort;
  final bool isSelected;
  final VoidCallback onTap;

  const _CaloriesAscendingSortWidget({
    required this.sort,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return _SortCategoryRowWidget(
      sort: sort,
      isSelected: isSelected,
      onTap: onTap,
    );
  }
}

class _CaloriesDescendingSortWidget extends StatelessWidget {
  final UISortOption sort;
  final bool isSelected;
  final VoidCallback onTap;

  const _CaloriesDescendingSortWidget({
    required this.sort,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return _SortCategoryRowWidget(
      sort: sort,
      isSelected: isSelected,
      onTap: onTap,
    );
  }
}

class _SortCategoryRowWidget extends StatelessWidget {
  final UISortOption sort;
  final bool isSelected;
  final VoidCallback onTap;

  const _SortCategoryRowWidget({
    required this.sort,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              sort.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? AppColors.primary : AppColors.textPrimary,
              ),
            ),
            if (isSelected)
              Icon(
                sort.direction == SortDirection.ascending
                    ? Icons.arrow_upward
                    : Icons.arrow_downward,
                color: AppColors.primary,
              ),
          ],
        ),
      ),
    );
  }
}