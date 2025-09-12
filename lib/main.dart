import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wellness/screens/active_log_screen.dart';
import 'providers/app_provider.dart';
import 'screens/onboarding_screen.dart';
import 'screens/home_screen.dart';
import 'screens/progress_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  const MyApp({required this.prefs, super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppProvider(prefs),
      child: Consumer<AppProvider>(
        builder: (context, state, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Wellness Tracker',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Color(0xfff5a63f)),
              useMaterial3: true,
            ),
            darkTheme: ThemeData.dark(),
            themeMode: state.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: state.isOnboarded ? const HomeScreen() : const OnboardingScreen(),
            routes: {
              HomeScreen.routeName: (_) => const HomeScreen(),
              ActivityLogScreen.routeName: (_) => const ActivityLogScreen(),
              ProgressScreen.routeName: (_) => const ProgressScreen(),
            },
          );
        },
      ),
    );
  }
}
