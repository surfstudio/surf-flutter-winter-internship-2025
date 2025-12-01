import 'package:flutter/material.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/ui_models/ui_fruit.dart';

import 'favorite_icon_button.dart';

class FruitCard extends StatelessWidget {
  final UIFruit fruit;
  final VoidCallback onFavoriteTap;
  final VoidCallback onTap;

  const FruitCard({
    super.key,
    required this.fruit,
    required this.onFavoriteTap,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => onTap(),
        borderRadius: BorderRadius.circular(12),
        child: ListTile(
          title: Text(fruit.name),
          subtitle: Text(fruit.family),
          trailing: FavoriteIconButton(fruit: fruit, onPressed: () {
            onFavoriteTap();
          },
        ),
      ),
    ),);
  }
}
