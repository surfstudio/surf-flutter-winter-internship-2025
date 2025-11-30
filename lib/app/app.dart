import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_flutter_winter_internship_2025/core/di/dependencies.dart';
import 'package:surf_flutter_winter_internship_2025/presentation/screens/tabs/tabs_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [...Dependencies.globalProviders()],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const TabsScreen(),
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.blue,
          checkboxTheme: CheckboxThemeData(
            fillColor: WidgetStateColor.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return Colors.blue;
              }
              return Colors.white;
            }),
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(foregroundColor: Colors.blue, backgroundColor: Colors.white),
          ),
          progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
