import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_flutter_winter_internship_2025/domain/services/interfaces/i_favorite_service.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/favorites/interfaces/i_get_favorites_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/favorites/interfaces/i_toggle_favorite_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/mappers/ui_fruit_mapper.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/screens/favorites/view_model/favorites_vm.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/screens/favorites/view_model/i_favorites_vm.dart';

import 'favorites_screen.dart';

class FavoriteScreenBuilder extends StatelessWidget {
  const FavoriteScreenBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<IFavoritesVM>(
      create: (context) => FavoritesVM(
        toggleFavoriteUseCase: context.read<IToggleFavoriteUseCase>(),
        favoritesService: context.read<IFavoritesService>(),
        getFavoritesUseCase: context.read<IGetFavoritesUseCase>(),
        uiFruitMapper: context.read<UIFruitMapper>(),
      ),
      child: const FavoritesScreen(),
    );
  }
}
