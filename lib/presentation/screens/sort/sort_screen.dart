import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/screens/sort/view_model/i_sort_screen_vm.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/screens/sort/widgets/filter_card_widget.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/screens/sort/widgets/sort_card_widget.dart';

class SortScreen extends StatelessWidget {
  const SortScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<ISortScreenVM>();

    return Scaffold(
      appBar: AppBar(
        // TODO: Extract
        title: const Text('Фильтры'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              vm.resetSortingAndFilters();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: ListView(
        children: [
          const Column(children: [SortCardWidget(), FilterCardWidget()]),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16),
          // TODO: Style
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            onPressed: () {
              vm.applySortingAndFilters(context);
            },
            child: const Text(
              'Применить',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
