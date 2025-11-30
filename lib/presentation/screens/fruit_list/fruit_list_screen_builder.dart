import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/fruits/apply_sort_and_filter_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/favorites/toggle_favorite_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/fruits/get_fruits_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/screens/fruit_list/view_model/fruit_list_vm.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/screens/fruit_list/view_model/i_fruit_list_vm.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/stores/favorites_store.dart';

import 'fruit_list_screen.dart';

class FruitListScreenBuilder extends StatelessWidget {
  const FruitListScreenBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<IFruitListVM>(
      create: (context) => FruitListVM(
        toggleFavoriteUseCase: context.read<ToggleFavoriteUseCase>(),
        getFruitsUseCase: context.read<GetFruitsUseCase>(),
        favoritesStore: context.read<FavoritesStore>(),
        applySortAndFilterUseCase: context.read<ApplySortAndFilterUseCase>(),
      ),
      child: const FruitListScreen(),
    );
  }
}
