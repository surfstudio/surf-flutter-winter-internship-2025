import 'package:sqflite/sqflite.dart';
import 'package:surf_flutter_winter_internship_2025/data/datasources/local/i_local_database.dart';

class LocalDatabase implements ILocalDataBase {
  static const String _favoritesTable = 'favorites';
  static const String _recipesTable = 'recipes';
  static Database? _database;


  Future<Database> get _db async {
    if (_database != null) return _database!;
    final partOfPath = await getDatabasesPath();
    final path = '${partOfPath}fruits.db';

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_favoritesTable (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            fruit_id INTEGER UNIQUE,
            name TEXT,
            family TEXT,
            order_text TEXT,
            genus TEXT,
            calories REAL,
            fat REAL,
            sugar REAL,
            carbohydrates REAL,
            protein REAL,
            created_at INTEGER
          )
         
        ''');
        await db.execute('''
        CREATE TABLE $_recipesTable (
          recipe_id TEXT PRIMARY KEY,
          name TEXT,
          description TEXT,
          fruits TEXT,
          created_at INTEGER
        )
      ''');
      },
    );
    return _database!;
  }

  @override
  Future<void> addFavorite(Map<String, dynamic> fruitMap) async {
    final db = await _db;
    await db.insert(
      _favoritesTable,
      fruitMap,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<Map<String, dynamic>>> getFavoriteFruits() async {
    final db = await _db;
    return await db.query(_favoritesTable);
  }

  @override
  Future<void> removeFavorite(int fruitId) async {
    final db = await _db;
    await db.delete(
      _favoritesTable,
      where: 'fruit_id = ?',
      whereArgs: [fruitId],
    );
  }

  @override
  Future<void> saveRecipe(Map<String, dynamic> recipe) async {
    final db = await _db;
    await db.insert(
      _recipesTable,
      recipe,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<Map<String, dynamic>>> getRecipes() async {
    final db = await _db;
    return await db.query(
      _recipesTable,
      orderBy: 'created_at DESC',
    );
  }

  @override
  Future<void> deleteRecipe(String recipeId) async {
    final db = await _db;
    await db.delete(
      _recipesTable,
      where: 'recipe_id = ?',
      whereArgs: [recipeId],
    );
  }
}