import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/filter_option.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/sort_option.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/mappers/ui_sort_filter_mapper.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/screens/sort/sort_screen.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/screens/sort/view_model/i_sort_screen_vm.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/screens/sort/view_model/sort_screen_vm.dart';

class SortScreenBuilder extends StatelessWidget {
  final Function(dynamic sort, dynamic filters) onApply;
  final SortOption? initialSort;
  final List<FilterType> initialFilters;

  const SortScreenBuilder({
    super.key,
    required this.onApply,
    required this.initialSort,
    required this.initialFilters,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ISortScreenVM>(
        create: (context) =>
            SortScreenVM(onApply: onApply,
              initialSort: initialSort,
              initialFilters: initialFilters,
              uiMapper: context.read<UISortFilterMapper>(),
            ),
              child: const SortScreen(),
            );
    }
}
