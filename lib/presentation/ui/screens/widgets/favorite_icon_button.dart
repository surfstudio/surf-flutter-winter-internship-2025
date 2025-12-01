import 'package:flutter/material.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/ui_models/ui_fruit.dart';

class FavoriteIconButton extends StatelessWidget {
  final UIFruit fruit;
  final VoidCallback onPressed;
  final double? iconSize;

  const FavoriteIconButton({
    super.key,
    required this.fruit,
    required this.onPressed,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      iconSize: iconSize,
      icon: Icon(
        fruit.isFavorite ? Icons.favorite : Icons.favorite_border,
        color: fruit.isFavorite ? Colors.red : Colors.grey,
      ),
      tooltip: fruit.isFavorite ? 'Remove from favorites' : 'Add to favorites',
    );
  }
}