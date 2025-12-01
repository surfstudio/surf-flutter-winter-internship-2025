import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_flutter_winter_internship_2025/assets/app_strings.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/screens/recipe_list/view_model/i_recipe_list_vm.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/screens/recipe_list/widgets/recipe_card_widget.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/screens/widgets/empty_state_widget.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/screens/widgets/error_widget.dart';

class RecipeListScreen extends StatelessWidget {
  const RecipeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<IRecipeListVM>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.recipes),
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
          ? EmptyStateWidget(
              onRefresh: () {
                vm.onCreateRecipeTap(context);
              },
              message: AppStrings.emptyRecipeList,
              icon: Icons.library_books,
              buttonText: AppStrings.createRecipe,
            )
          : vm.hasError
          ? ErrorStateWidget(
              onRetry: () {
                vm.retry();
              },
            )
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
