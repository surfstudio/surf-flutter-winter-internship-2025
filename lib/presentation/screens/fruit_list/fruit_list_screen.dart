import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/screens/fruit_list/view_model/i_fruit_list_vm.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/widgets/fruit_card.dart';

class FruitListScreen extends StatelessWidget {
  const FruitListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<IFruitListVM>();

    return Scaffold(
      appBar: AppBar(
        // TODO: Extract
        title: const Text('Фрукты'),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.sort), onPressed: () { vm.onSortTap(context);}),
        ],
      ),
      body: vm.isLoading
          ? const Center(child: CircularProgressIndicator())
          : vm.fruits.isEmpty
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

class _ErrorWidget extends StatelessWidget {
  final IFruitListVM vm;

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
          const Icon(Icons.apple, size: 64, color: Colors.white),
          const SizedBox(height: 16),
          const Text(
            'Фрукты не найдены',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => context.read<IFruitListVM>().retry(),
            child: const Text('Обновить'),
          ),
        ],
      ),
    );
  }
}
