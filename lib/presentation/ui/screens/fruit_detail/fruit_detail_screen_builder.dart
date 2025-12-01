import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/fruit.dart';
import 'package:surf_flutter_winter_internship_2025/domain/services/interfaces/i_favorite_service.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/favorites/interfaces/i_toggle_favorite_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/mappers/ui_fruit_mapper.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/screens/fruit_detail/view_model/fruit_detail_vm.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/screens/fruit_detail/view_model/i_fruit_detail_vm.dart';

import 'fruit_detail_screen.dart';

class FruitDetailScreenBuilder extends StatelessWidget {
  final Fruit fruit;

  const FruitDetailScreenBuilder({super.key, required this.fruit});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<IFruitDetailVM>(
      create: (context) => FruitDetailVM(
        toggleFavoriteUseCase: context.read<IToggleFavoriteUseCase>(),
        favoritesService: context.read<IFavoritesService>(),
        fruit: fruit,
        uiFruitMapper: context.read<UIFruitMapper>(),
      ),
      child: const FruitDetailScreen(),
    );
  }
}
