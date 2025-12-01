import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_flutter_winter_internship_2025/assets/app_strings.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/screens/favorites/view_model/i_favorites_vm.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/screens/widgets/empty_state_widget.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/screens/widgets/error_widget.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/screens/widgets/fruit_card.dart';

class FavoritesScreen extends StatelessWidget {

  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<IFavoritesVM>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.favorites),
        centerTitle: true,
      ),
      body:  vm.isLoading
          ? const Center(child: CircularProgressIndicator())
          : vm.isEmpty
          ? EmptyStateWidget(onRefresh: () {vm.retry();}, message: AppStrings.emptyFavorites, icon: Icons.favorite_border)
          : vm.hasError
          ? ErrorStateWidget(onRetry: () {vm.retry();},)
          : ListView.builder(
        itemCount: vm.fruits.length,
        itemBuilder: (BuildContext context, int index) {
          final fruit = vm.fruits[index];
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 4.0,
            ),
            child: FruitCard(
              fruit: fruit,
              onTap: () {
                vm.onCardTap(context, fruit);
              },
              onFavoriteTap: () {
                vm.onFavoriteTap(fruit);
              },
            ),
          );
        },
      ),
    );
  }
}