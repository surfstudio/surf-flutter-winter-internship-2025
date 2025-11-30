import 'package:surf_flutter_winter_internship_2025/data/datasources/local_datasource.dart';
import 'package:surf_flutter_winter_internship_2025/data/mappers/recipe_local_mapper.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/recipe.dart';
import 'package:surf_flutter_winter_internship_2025/domain/repositories/i_recipe_repository.dart';

import 'base_local_repository.dart';

final class RecipeRepository extends BaseLocalRepository implements IRecipeRepository {
  final LocalDataSource _localDataSource;
  final RecipeLocalMapper _recipeLocalMapper;

  RecipeRepository({
    required LocalDataSource localDataSource,
    required RecipeLocalMapper recipeLocalMapper,
  })  : _localDataSource = localDataSource,
        _recipeLocalMapper = recipeLocalMapper;

  @override
  Future<void> saveRecipe(Recipe recipe) async {
    return handleLocalException(() async {
      final recipeMap = _recipeLocalMapper.toStorageModel(recipe);
      await _localDataSource.saveRecipe(recipeMap);
    });
  }

  @override
  Future<void> deleteRecipe(String recipeId) async {
    return handleLocalException(() async {
      await _localDataSource.deleteRecipe(recipeId);
    });
  }

  @override
  Future<List<Recipe>> getRecipes() async {
    return handleLocalException(() async {
      final maps = await _localDataSource.getRecipes();
      return _recipeLocalMapper.toEntityList(maps);
    });
  }

  @override
  Future<Recipe?> getRecipeById(String recipeId) async {
    return handleLocalException(() async {
      final maps = await _localDataSource.getRecipes();
      final recipeMap = maps.firstWhere(
            (map) => map['recipe_id'] == recipeId,
        orElse: () => <String, dynamic>{},
      );

      if (recipeMap.isEmpty) return null;
      return _recipeLocalMapper.toEntity(recipeMap);
    });
  }
}