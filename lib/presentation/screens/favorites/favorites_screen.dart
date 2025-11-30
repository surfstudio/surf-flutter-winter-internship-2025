import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/screens/favorites/view_model/i_favorites_vm.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/widgets/fruit_card.dart';

class FavoritesScreen extends StatelessWidget {

  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<IFavoritesVM>();

    return Scaffold(
      appBar: AppBar(
        // TODO: Extract
        title: const Text('Избранное'),
        centerTitle: true,
      ),
      body:  vm.isLoading
          ? const Center(child: CircularProgressIndicator())
          : vm.isEmpty
          ? const _EmptyStateWidget()
          : vm.hasError
          ? _ErrorWidget(vm: vm)
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

// TODO: Extract
class _ErrorWidget extends StatelessWidget {
  final IFavoritesVM vm;

  const _ErrorWidget({required this.vm});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.white),
          const SizedBox(height: 16),
          const Text(
            'Произошла ошибка',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: vm.retry,
            child: const Text('Повторить'),
          ),
        ],
      ),
    );
  }
}

class _EmptyStateWidget extends StatelessWidget {
  const _EmptyStateWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.favorite_border, size: 64, color: Colors.white),
          const SizedBox(height: 16),
          const Text(
            'В избранном пока ничего нет',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => context.read<IFavoritesVM>().retry(),
            child: const Text('Обновить'),
          ),
        ],
      ),
    );
  }
}
