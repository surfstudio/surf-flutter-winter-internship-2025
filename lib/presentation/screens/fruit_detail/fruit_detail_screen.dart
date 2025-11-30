import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/fruit.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/screens/fruit_detail/view_model/i_fruit_detail_vm.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/screens/fruit_detail/widgets/fruit_detail_card_widget.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/widgets/favorite_icon_button.dart';

class FruitDetailScreen extends StatelessWidget {

  const FruitDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<IFruitDetailVM>();
    final Fruit fruit = vm.fruit;

    return Scaffold(
        appBar: AppBar(
          // TODO: Extract
          title: Text(fruit.name, style: const TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
          actions: [
            FavoriteIconButton(fruit: fruit, onPressed: () {
              vm.onFavoriteTap();
            }
            ),
          ],
        ),
        body: ListView(children:[ FruitDetailCardWidget(fruit: fruit)]),
        );
  }
}

