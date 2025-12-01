# Fruit App - Nutrition Tech Application

Nutrition-tech приложение для подбора фруктов и составления рецептов на основе пищевой ценности. (Для Surf-Flutter-Winter-Internship)

## 📱 Функциональность

### Основные экраны
- **Список фруктов** - просмотр всех фруктов из API с сортировкой и фильтрацией
- **Избранное** - управление списком любимых фруктов с локальным сохранением
- **Рецепты** - создание и просмотр рецептов из избранных фруктов

### Ключевые возможности
- 📊 Просмотр пищевой ценности фруктов (калории, белки, углеводы, жиры, сахар)
- ⭐ Добавление/удаление фруктов в избранное с сохранением на устройстве
- 🔍 Сортировка и фильтрация фруктов по различным параметрам
- 🍽️ Создание рецептов из избранных фруктов
- 📱 Адаптивный интерфейс для iOS и Android

## 🏗️ Архитектура

### Clean Architecture
Проект построен по принципам Clean Architecture с четким разделением на слои:

#### Data Layer
- **Repositories**: `FruitsRepository`, `FavoritesRepository`, `RecipeRepository`
- **Data Sources**: `ApiClient` (REST API), `LocalDatabase` (локальное хранилище)
- **Mappers**: `FruitNetworkMapper`, `FruitLocalMapper`, `RecipeLocalMapper`

#### Domain Layer
- **Use Cases**:
   - `GetFruitsUseCase`, `ApplySortAndFilterUseCase`
   - `GetFavoritesUseCase`, `ToggleFavoriteUseCase`, `WatchFavoritesUseCase`
   - `GetRecipesUseCase`, `CreateRecipeUseCase`, `DeleteRecipeUseCase`
- **Services**: `FavoritesService`, `FilterService`, `SortService`
- **Entities**: `Fruit`, `Recipe`, `SortOption`, `FilterType`

#### Presentation Layer
- **ViewModels**: `FruitListVM`, `FavoritesVM`, `FruitDetailVM`, `RecipesVM`, `RecipeCreateVM`
- **UI Mappers**: `UIFruitMapper`, `UIRecipeMapper`
- **Screens**: Все экраны приложения

### Используемые подходы
- MVVM с ChangeNotifier (из Provider) для управления состоянием
- Provider для dependency injection
- Repository pattern для доступа к данным
- Use Cases для инкапсуляции бизнес-логики

## 🛠️ Технический стек

- **Flutter**: 3.35.7
- **Dart**: 3.9.2
- **State Management**: Provider + ChangeNotifier
- **Networking**: Retrofit для HTTP запросов
- **Local Storage**: SQLite через sqflite
- **Navigation**: Custom Navigator (`MainNavigation`)