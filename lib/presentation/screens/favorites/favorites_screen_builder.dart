import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/favorites/get_favorites_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/favorites/toggle_favorite_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/screens/favorites/view_model/favorites_vm.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/screens/favorites/view_model/i_favorites_vm.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/stores/favorites_store.dart';

import 'favorites_screen.dart';

class FavoriteScreenBuilder extends StatelessWidget {
  const FavoriteScreenBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<IFavoritesVM>(
      create: (context) => FavoritesVM(
        toggleFavoriteUseCase: context.read<ToggleFavoriteUseCase>(),
        favoritesStore: context.read<FavoritesStore>(),
        getFavoritesUseCase: context.read<GetFavoritesUseCase>(),
      ),
      child: const FavoritesScreen(),
    );
  }
}
