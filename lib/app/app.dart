import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_flutter_winter_internship_2025/core/di/dependencies.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/screens/tabs/tabs_screen.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/ui/uikit/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [...Dependencies.globalProviders()],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const TabsScreen(),
        theme: AppTheme.light,
      ),
    );
  }
}
