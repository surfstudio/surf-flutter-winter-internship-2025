import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/recipes/interfaces/i_delete_recipe_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/recipes/interfaces/i_get_recipe_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/mappers/ui_recipe_mapper.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/screens/recipe_list/recipe_list_screen.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/screens/recipe_list/view_model/i_recipe_list_vm.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/screens/recipe_list/view_model/recipe_list_vm.dart';

class RecipeListScreenBuilder extends StatelessWidget {
  const RecipeListScreenBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<IRecipeListVM>(
      create: (context) => RecipeListVM(
        deleteRecipeUseCase: context.read<IDeleteRecipeUseCase>(),
        getRecipesUseCase: context.read<IGetRecipesUseCase>(),
        uiRecipeMapper: context.read <UIRecipeMapper>(),
      ),
      child: const RecipeListScreen(),
    );
  }
}
