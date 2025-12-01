import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_flutter_winter_internship_2025/assets/app_strings.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/screens/sort/view_model/i_sort_screen_vm.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/ui_models/ui_filter_option.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/uikit/colors/app_colors.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/uikit/text_styles/app_text_styles.dart';

class FilterCardWidget extends StatelessWidget {
  const FilterCardWidget({super.key});

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
            _FilterCategoriesWidget(filterOptions: vm.filterOptions),
          ],
        ),
      ),
    );
  }
}

class _FilterCategoriesWidget extends StatelessWidget {
  final List<UIFilterOption> filterOptions;

  const _FilterCategoriesWidget({required this.filterOptions});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<ISortScreenVM>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.filters,
          style: AppTextStyles.titleMedium,
        ),
        const SizedBox(height: 10),
        Column(
          children: List.generate(
            filterOptions.length,
                (index) => Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: _FilterCategoryRowWidget(
                filter: filterOptions[index],
                onChanged: (value) => vm.toggleFilter(filterOptions[index]),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _FilterCategoryRowWidget extends StatelessWidget {
  final UIFilterOption filter;
  final Function(bool?) onChanged;

  const _FilterCategoryRowWidget({
    required this.filter,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                filter.title,
                style: AppTextStyles.bodyLarge,
              ),
              const SizedBox(height: 4),
              Text(
                filter.description,
                style: AppTextStyles.bodySmall,
              )],
          ),
        ),
        Checkbox(
          value: filter.isSelected,
          onChanged: onChanged,
        ),
      ],
    );
  }
}