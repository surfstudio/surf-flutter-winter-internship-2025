import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/screens/fruit_detail/view_model/i_fruit_detail_vm.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/screens/fruit_detail/widgets/fruit_detail_card_widget.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/screens/widgets/favorite_icon_button.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/uikit/text_styles/app_text_styles.dart';

class FruitDetailScreen extends StatelessWidget {

  const FruitDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<IFruitDetailVM>();
    final fruit = vm.fruit;

    return Scaffold(
      appBar: AppBar(
        title: Text(fruit.name, style: AppTextStyles.titleMedium),
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
