import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/sort_option.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/screens/sort/view_model/i_sort_screen_vm.dart';

class SortCardWidget extends StatelessWidget {
  const SortCardWidget({super.key});
  // TODO: BAD

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ISortScreenVM>();

    return Card(
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
  final List<SortOption> sortOptions;
  final SortOption? selectedSort;

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
          'Сортировка',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ...sortOptions.map((sort) => Column(
          children: [
            _SortCategoryRowWidget(
              sort: sort,
              isSelected: selectedSort == sort,
              onTap: () => vm.selectSort(sort),
            ),
            const SizedBox(height: 12),
          ],
        )),
      ],
    );
  }
}

class _SortCategoryRowWidget extends StatelessWidget {
  final SortOption sort;
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
                color: isSelected ? Colors.blue : Colors.black,
              ),
            ),
            if (isSelected)
              Icon(
                sort.direction == SortDirection.ascending
                    ? Icons.arrow_upward
                    : Icons.arrow_downward,
                color: Colors.blue,
              ),
          ],
        ),
      ),
    );
  }
}