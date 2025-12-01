import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/fruits/interfaces/i_get_fruits_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/recipes/interfaces/i_create_recipe_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/mappers/ui_fruit_mapper.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/screens/recipe_create/recipe_create_screen.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/screens/recipe_create/view_model/i_recipe_create_vm.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/screens/recipe_create/view_model/recipe_screen_vm.dart';

class RecipeCreateScreenBuilder extends StatelessWidget {
  const RecipeCreateScreenBuilder({super.key});

  @override
  Widget build(BuildContext context) {
        return ChangeNotifierProvider<IRecipeCreateVM>(
          create: (context) => RecipeCreateVM(
            getFruitsUseCase: context.read<IGetFruitsUseCase>(),
            createRecipeUseCase: context.read<ICreateRecipeUseCase>(),
            uiFruitMapper: context.read<UIFruitMapper>(),
          ),
      child: const RecipeCreateScreen(),
    );
  }
}