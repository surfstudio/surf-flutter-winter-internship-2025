import 'package:flutter/material.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/screens/favorites/favorites_screen_builder.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/screens/fruit_list/fruit_list_screen_builder.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/screens/recipe_list/recipe_list_screen_builder.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const FruitListScreenBuilder(),
    const FavoriteScreenBuilder(),
    const RecipeListScreenBuilder(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:IndexedStack(
      index: _currentIndex,
      children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.apple_sharp), label: 'Фрукты'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Избранное'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt), label: 'Рецепты'),
        ],
      ),
    );
  }
}
