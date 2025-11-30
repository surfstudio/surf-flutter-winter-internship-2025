import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:surf_flutter_winter_internship_2025/data/datasources/api_client.dart';
import 'package:surf_flutter_winter_internship_2025/data/datasources/local_database.dart';
import 'package:surf_flutter_winter_internship_2025/data/datasources/local_datasource.dart';
import 'package:surf_flutter_winter_internship_2025/data/mappers/fruit_local_mapper.dart';
import 'package:surf_flutter_winter_internship_2025/data/mappers/fruit_network_mapper.dart';
import 'package:surf_flutter_winter_internship_2025/data/mappers/recipe_local_mapper.dart';
import 'package:surf_flutter_winter_internship_2025/data/repositories/favorites.repository.dart';
import 'package:surf_flutter_winter_internship_2025/data/repositories/fruits_repository.dart';
import 'package:surf_flutter_winter_internship_2025/data/repositories/recipe_repository.dart';
import 'package:surf_flutter_winter_internship_2025/domain/repositories/i_favorites_repository.dart';
import 'package:surf_flutter_winter_internship_2025/domain/repositories/i_fruits_repository.dart';
import 'package:surf_flutter_winter_internship_2025/domain/repositories/i_recipe_repository.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/fruits/apply_sort_and_filter_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/favorites/get_favorites_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/favorites/toggle_favorite_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/favorites/watch_favorites_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/fruits/get_fruits_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/recipes/delete_recipe_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/recipes/get_recipes_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/stores/favorites_store.dart';

class Dependencies {
  static List<SingleChildWidget> globalProviders() {
    return [
      // Dio
      Provider<Dio>(
        create: (_) {
          final dio = Dio();
          dio.options.connectTimeout = const Duration(seconds: 30);
          dio.options.receiveTimeout = const Duration(seconds: 30);
          return dio;
        },
      ),

      // API Client
      Provider<ApiClient>(create: (context) => ApiClient(context.read<Dio>())),

      // Mappers
      Provider<FruitNetworkMapper>(create: (_) => FruitNetworkMapper()),
      Provider<FruitLocalMapper>(create: (_) => FruitLocalMapper()),
      Provider<RecipeLocalMapper>(create: (_) => RecipeLocalMapper()),

      // DataSources
      Provider<LocalDataSource>(create: (_) => LocalDatabase()),

      // Repositories
      Provider<IFruitsRepository>(
        create: (context) => FruitsRepository(
          apiClient: context.read<ApiClient>(),
          fruitMapper: context.read<FruitNetworkMapper>(),
        ),
      ),

      Provider<IFavoritesRepository>(
        create: (context) => FavoritesRepository(
          localDataSource: context.read<LocalDataSource>(),
          fruitLocalMapper: context.read<FruitLocalMapper>(),
        ),
      ),

      Provider<IRecipeRepository>(
        create: (context) => RecipeRepository(
          localDataSource: context.read<LocalDataSource>(),
          recipeLocalMapper: RecipeLocalMapper(),
        ),
      ),

      // Use Cases - Fruits
      Provider<GetFruitsUseCase>(
        create: (context) =>
            GetFruitsUseCase(context.read<IFruitsRepository>()),
      ),

      Provider<ApplySortAndFilterUseCase>(
        create: (context) => ApplySortAndFilterUseCase(),
      ),

      // Use Cases - Favorites
      Provider<WatchFavoritesUseCase>(
        create: (context) =>
            WatchFavoritesUseCase(context.read<IFavoritesRepository>()),
      ),

      ChangeNotifierProvider<FavoritesStore>(
        create: (context) =>
            FavoritesStore(context.read<WatchFavoritesUseCase>()),
      ),

      Provider<ToggleFavoriteUseCase>(
        create: (context) => ToggleFavoriteUseCase(
          favoriteRepository: context.read<IFavoritesRepository>(),
        ),
      ),

      Provider<GetFavoritesUseCase>(
        create: (context) =>
            GetFavoritesUseCase(context.read<IFavoritesRepository>()),
      ),

      // Use Cases - Recipes
      Provider<GetRecipesUseCase>(
        create: (context) => GetRecipesUseCase(
          recipeRepository: context.read<IRecipeRepository>(),
        ),
      ),

      Provider<DeleteRecipeUseCase>(
        create: (context) => DeleteRecipeUseCase(
          recipeRepository: context.read<IRecipeRepository>(),
        ),
      ),
    ];
  }
}
