import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:surf_flutter_winter_internship_2025/data/datasources/remote/api_client.dart';
import 'package:surf_flutter_winter_internship_2025/data/datasources/local/local_database.dart';
import 'package:surf_flutter_winter_internship_2025/data/datasources/local/i_local_database.dart';
import 'package:surf_flutter_winter_internship_2025/data/mappers/local/fruit_local_mapper.dart';
import 'package:surf_flutter_winter_internship_2025/data/mappers/remote/fruit_network_mapper.dart';
import 'package:surf_flutter_winter_internship_2025/data/mappers/local/recipe_local_mapper.dart';
import 'package:surf_flutter_winter_internship_2025/data/repositories/local/favorites.repository.dart';
import 'package:surf_flutter_winter_internship_2025/data/repositories/remote/fruits_repository.dart';
import 'package:surf_flutter_winter_internship_2025/data/repositories/local/recipe_repository.dart';
import 'package:surf_flutter_winter_internship_2025/domain/repositories/i_favorites_repository.dart';
import 'package:surf_flutter_winter_internship_2025/domain/repositories/i_fruits_repository.dart';
import 'package:surf_flutter_winter_internship_2025/domain/repositories/i_recipe_repository.dart';
import 'package:surf_flutter_winter_internship_2025/domain/services/filter_service.dart';
import 'package:surf_flutter_winter_internship_2025/domain/services/interfaces/i_favorite_service.dart';
import 'package:surf_flutter_winter_internship_2025/domain/services/interfaces/i_filter_service.dart';
import 'package:surf_flutter_winter_internship_2025/domain/services/interfaces/i_sort_service.dart';
import 'package:surf_flutter_winter_internship_2025/domain/services/sort_service.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/favorites/interfaces/i_get_favorites_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/favorites/interfaces/i_toggle_favorite_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/favorites/interfaces/i_watch_favorites_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/favorites/get_favorites_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/favorites/toggle_favorite_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/favorites/watch_favorites_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/fruits/apply_sort_and_filter_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/fruits/get_fruits_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/fruits/interfaces/i_apply_sort_and_filter_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/fruits/interfaces/i_get_fruits_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/recipes/create_recipe_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/recipes/delete_recipe_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/recipes/get_recipes_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/recipes/interfaces/i_create_recipe_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/recipes/interfaces/i_delete_recipe_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/domain/use_cases/recipes/interfaces/i_get_recipe_use_case.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/mappers/ui_fruit_mapper.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/mappers/ui_recipe_mapper.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/mappers/ui_sort_filter_mapper.dart';

import '../../domain/services/favorites_service.dart';

//TODO: DI

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

      // Mappers (Data)
      Provider<FruitNetworkMapper>(create: (_) => FruitNetworkMapper()),
      Provider<FruitLocalMapper>(create: (_) => FruitLocalMapper()),
      Provider<RecipeLocalMapper>(create: (_) => RecipeLocalMapper()),

      // DataSources
      Provider<ILocalDataBase>(create: (_) => LocalDatabase()),

      // Repositories
      Provider<IFruitsRepository>(
        create: (context) => FruitsRepository(
          apiClient: context.read<ApiClient>(),
          fruitMapper: context.read<FruitNetworkMapper>(),
        ),
      ),

      Provider<IFavoritesRepository>(
        create: (context) => FavoritesRepository(
          localDataSource: context.read<ILocalDataBase>(),
          fruitLocalMapper: context.read<FruitLocalMapper>(),
        ),
      ),

      Provider<IRecipeRepository>(
        create: (context) => RecipeRepository(
          localDataSource: context.read<ILocalDataBase>(),
          recipeLocalMapper: context.read<RecipeLocalMapper>(),
        ),
      ),

      // Use Cases - Favorites
      Provider<IWatchFavoritesUseCase>(
        create: (context) =>
            WatchFavoritesUseCase(context.read<IFavoritesRepository>()),
      ),

      Provider<IToggleFavoriteUseCase>(
        create: (context) => ToggleFavoriteUseCase(
          favoriteRepository: context.read<IFavoritesRepository>(),
        ),
      ),

      Provider<IGetFavoritesUseCase>(
        create: (context) =>
            GetFavoritesUseCase(context.read<IFavoritesRepository>()),
      ),

      // Services
      Provider<IFavoritesService>(
        create: (context) =>
            FavoritesService(context.read<IWatchFavoritesUseCase>()),
      ),

      Provider<IFilterService>(
        create: (context) => FilterService(),
      ),

      Provider<ISortService>(
        create: (context) => SortService(),
      ),

      // Use Cases - Fruits
      Provider<IGetFruitsUseCase>(
        create: (context) =>
            GetFruitsUseCase(context.read<IFruitsRepository>()),
      ),

      Provider<IApplySortAndFilterUseCase>(
        create: (context) => ApplySortAndFilterUseCase(
          filterService: context.read<IFilterService>(),
          sortService: context.read<ISortService>(),
        ),
      ),

      // Use Cases - Recipes
      Provider<IGetRecipesUseCase>(
        create: (context) => GetRecipesUseCase(
          recipeRepository: context.read<IRecipeRepository>(),
        ),
      ),

      Provider<IDeleteRecipeUseCase>(
        create: (context) => DeleteRecipeUseCase(
          recipeRepository: context.read<IRecipeRepository>(),
        ),
      ),

      Provider<ICreateRecipeUseCase>(
        create: (context) => CreateRecipeUseCase(
          recipeRepository: context.read<IRecipeRepository>(),
        ),
      ),

      // Mappers (Presentation)
      Provider<UIFruitMapper>(create: (context) => UIFruitMapper()),

      Provider<UIRecipeMapper>(
        create: (context) =>
            UIRecipeMapper(fruitMapper: context.read<UIFruitMapper>()),
      ),
      Provider<UISortFilterMapper>(create: (context) => UISortFilterMapper()),
    ];
  }
}
