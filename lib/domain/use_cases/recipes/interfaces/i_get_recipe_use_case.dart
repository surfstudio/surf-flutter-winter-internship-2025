import 'package:surf_flutter_winter_internship_2025/domain/entities/recipe.dart';

abstract interface class IGetRecipesUseCase {
  Future<List<Recipe>> call();
}
