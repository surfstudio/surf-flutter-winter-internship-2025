import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_flutter_winter_internship_2025/assets/app_strings.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/screens/fruit_list/view_model/i_fruit_list_vm.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/screens/widgets/empty_state_widget.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/screens/widgets/error_widget.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/screens/widgets/fruit_card.dart';

class FruitListScreen extends StatelessWidget {
  const FruitListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<IFruitListVM>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.fruits),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.sort), onPressed: () { vm.onSortTap(context);}),
        ],
      ),
      body:  vm.isLoading
          ? const Center(child: CircularProgressIndicator())
          : vm.fruits.isEmpty
          ? EmptyStateWidget(onRefresh: () {vm.retry();}, message: AppStrings.emptyFruitList, icon: Icons.apple)
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
