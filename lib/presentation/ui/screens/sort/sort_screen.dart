import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_flutter_winter_internship_2025/assets/app_strings.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/screens/sort/view_model/i_sort_screen_vm.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/screens/sort/widgets/filter_card_widget.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/screens/sort/widgets/sort_card_widget.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/uikit/colors/app_colors.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/uikit/text_styles/app_text_styles.dart';

class SortScreen extends StatelessWidget {
  const SortScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<ISortScreenVM>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.filters),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              vm.resetSortingAndFilters();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: ListView(
        children: [
          const Column(children: [SortCardWidget(), FilterCardWidget()]),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: AppColors.bottomNavBar,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: AppColors.onSurface,
              backgroundColor: AppColors.primary,
              minimumSize: const Size(double.infinity, 48),
              textStyle: AppTextStyles.button,
            ),
            onPressed: () {
              vm.applySortingAndFilters(context);
            },
            child: const Text(AppStrings.apply),
          ),
        ),
      ),
    );
  }
}
