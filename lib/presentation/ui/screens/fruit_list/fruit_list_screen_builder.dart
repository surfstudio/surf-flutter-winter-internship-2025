import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_flutter_winter_internship_2025/domain/services/favorites_service.dart';
import 'package:surf_flutter_winter_internship_2025/domain/services/interfaces/i_favorite_service.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/favorites/interfaces/i_toggle_favorite_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/fruits/interfaces/i_apply_sort_and_filter_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/fruits/interfaces/i_get_fruits_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/mappers/ui_fruit_mapper.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/screens/fruit_list/view_model/fruit_list_vm.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/screens/fruit_list/view_model/i_fruit_list_vm.dart';

import 'fruit_list_screen.dart';

class FruitListScreenBuilder extends StatelessWidget {
  const FruitListScreenBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<IFruitListVM>(
      create: (context) => FruitListVM(
        toggleFavoriteUseCase: context.read<IToggleFavoriteUseCase>(),
        getFruitsUseCase: context.read<IGetFruitsUseCase>(),
        favoritesService: context.read<IFavoritesService>(),
        applySortAndFilterUseCase: context.read<IApplySortAndFilterUseCase>(),
        uiFruitMapper: context.read<UIFruitMapper>(),
      ),
      child: const FruitListScreen(),
    );
  }
}
