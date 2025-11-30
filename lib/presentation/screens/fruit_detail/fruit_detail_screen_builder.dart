import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/fruit.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/favorites/toggle_favorite_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/screens/fruit_detail/view_model/fruit_detail_vm.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/screens/fruit_detail/view_model/i_fruit_detail_vm.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/stores/favorites_store.dart';

import 'fruit_detail_screen.dart';

class FruitDetailScreenBuilder extends StatelessWidget {
  final Fruit fruit;

  const FruitDetailScreenBuilder({super.key, required this.fruit});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<IFruitDetailVM>(
      create: (context) => FruitDetailVM(
        toggleFavoriteUseCase: context.read<ToggleFavoriteUseCase>(),
        favoritesStore: context.read<FavoritesStore>(),
        fruit: fruit,
      ),
      child: const FruitDetailScreen(),
    );
  }
}
