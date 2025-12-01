import 'package:surf_flutter_winter_internship_2025/domain/entities/recipe.dart';

abstract interface class ICreateRecipeUseCase {
  Future<void> call(Recipe recipe);
}