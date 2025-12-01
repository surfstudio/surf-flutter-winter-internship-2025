import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_flutter_winter_internship_2025/assets/app_strings.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/navigation/main_navigation.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/screens/recipe_create/view_model/i_recipe_create_vm.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/ui_models/ui_fruit.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/uikit/colors/app_colors.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/uikit/decorations/app_decorations.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/uikit/text_styles/app_text_styles.dart';

class RecipeCreateScreen extends StatelessWidget {
  const RecipeCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.createRecipe),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () => MainNavigation.pop(context),
          ),
        ],
      ),
      body: const _RecipeCreateForm(),
      floatingActionButton: const _CreateRecipeButton(),
    );
  }
}

class _RecipeCreateForm extends StatelessWidget {
  const _RecipeCreateForm();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<IRecipeCreateVM>();

    if (vm.isLoading && vm.availableFruits.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (vm.hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${AppStrings.errorWithParam}${vm.error}', style: AppTextStyles.bodyMedium),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: vm.loadAvailableFruits,
              child: const Text(AppStrings.retry),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _RecipeNameField(vm: vm),
          const SizedBox(height: 16),
          _RecipeDescriptionField(vm: vm),
          const SizedBox(height: 24),
          _SelectedFruitsSection(vm: vm),
          const SizedBox(height: 24),
          _AvailableFruitsSection(vm: vm),
        ],
      ),
    );
  }
}

class _RecipeNameField extends StatelessWidget {
  final IRecipeCreateVM vm;

  const _RecipeNameField({required this.vm});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: AppDecorations.textField(
        label: AppStrings.recipeName,
        hint: AppStrings.enterRecipeName,
      ),
      onChanged: vm.onRecipeNameChanged,
      textInputAction: TextInputAction.next,
    );
  }
}

class _RecipeDescriptionField extends StatelessWidget {
  final IRecipeCreateVM vm;

  const _RecipeDescriptionField({required this.vm});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: AppDecorations.textField(
        label: AppStrings.recipeDescription,
        hint: AppStrings.enterRecipeDescription,
      ),
      onChanged: vm.onRecipeDescriptionChanged,
      maxLines: 3,
      textInputAction: TextInputAction.next,
    );
  }
}

class _SelectedFruitsSection extends StatelessWidget {
  final IRecipeCreateVM vm;

  const _SelectedFruitsSection({required this.vm});

  @override
  Widget build(BuildContext context) {
    if (vm.selectedFruits.isEmpty) {
      return const _SectionTitle(
        title: AppStrings.selectedFruits,
        subtitle: AppStrings.chooseFruits,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(title: AppStrings.selectedFruits),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: vm.selectedFruits.map((fruit) {
            return Chip(
              label: Text(fruit.name, style: AppTextStyles.bodyMedium),
              deleteIcon: const Icon(Icons.close, size: 16),
              onDeleted: () => vm.onFruitDeselected(fruit),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _AvailableFruitsSection extends StatelessWidget {
  final IRecipeCreateVM vm;

  const _AvailableFruitsSection({required this.vm});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(title: AppStrings.availableFruits),
        const SizedBox(height: 8),
        ...vm.availableFruits.map((fruit) {
          final isSelected = vm.selectedFruits.any((f) => f.id == fruit.id);
          return _FruitSelectionItem(
            fruit: fruit,
            isSelected: isSelected,
            onTap: () => isSelected
                ? vm.onFruitDeselected(fruit)
                : vm.onFruitSelected(fruit),
          );
        }),
      ],
    );
  }
}

class _FruitSelectionItem extends StatelessWidget {
  final UIFruit fruit;
  final bool isSelected;
  final VoidCallback onTap;

  const _FruitSelectionItem({
    required this.fruit,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: isSelected ? AppColors.primary.withAlpha(30) : AppColors.card,
      child: ListTile(
        leading: Icon(
          isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
          color: isSelected ? AppColors.primary : AppColors.textSecondary,
        ),
        title: Text(fruit.name, style: AppTextStyles.bodyMedium),
        subtitle: Text('${fruit.nutritions.calories} ${AppStrings.kcal}', style: AppTextStyles.bodySmall),
        onTap: onTap,
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final String? subtitle;

  const _SectionTitle({
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.titleMedium,
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 4),
          Text(
            subtitle!,
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ],
    );
  }
}

class _CreateRecipeButton extends StatelessWidget {
  const _CreateRecipeButton();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<IRecipeCreateVM>();

    return FloatingActionButton.extended(
      onPressed: vm.canCreateRecipe ? () => _createRecipe(context, vm) : null,
      label: const Text(AppStrings.createRecipeButton, style: AppTextStyles.button),
      icon: vm.isLoading
          ? const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(strokeWidth: 2),
      )
          : const Icon(Icons.add),
    );
  }

  Future<void> _createRecipe(BuildContext context, IRecipeCreateVM vm) async {
    await vm.createRecipe();

    if (!vm.hasError && !vm.isLoading) {
      if (context.mounted) {
        MainNavigation.pop(context, true);
      }
    }
  }
}