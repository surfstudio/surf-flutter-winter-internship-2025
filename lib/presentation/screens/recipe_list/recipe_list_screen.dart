import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/screens/recipe_list/view_model/i_recipe_list_vm.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/screens/recipe_list/widgets/recipe_card_widget.dart';

class RecipeListScreen extends StatelessWidget {
  const RecipeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<IRecipeListVM>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Рецепты'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => vm.onCreateRecipeTap(context),
          ),
        ],
      ),
      body: vm.isLoading
          ? const Center(child: CircularProgressIndicator())
          : vm.recipes.isEmpty
          ? const _EmptyStateWidget()
          : vm.hasError
          ? _ErrorWidget(vm: vm)
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: vm.recipes.length,
        itemBuilder: (BuildContext context, int index) {
          final recipe = vm.recipes[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: RecipeCardWidget(
              recipe: recipe,
              onDeleteTap: () => vm.onDeleteRecipeTap(recipe),
            ),
          );
        },
      ),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  final IRecipeListVM vm;

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
          const Icon(Icons.menu_book, size: 64, color: Colors.white),
          const SizedBox(height: 16),
          const Text(
            'Создайте свой первый рецепт',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => context.read<IRecipeListVM>().onCreateRecipeTap(context),
            child: const Text('Создать рецепт'),
          ),
        ],
      ),
    );
  }
}