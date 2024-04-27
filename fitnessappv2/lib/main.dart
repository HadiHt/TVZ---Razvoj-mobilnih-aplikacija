import 'package:firebase_core/firebase_core.dart';
import 'package:fitnessappv2/Themes/custom_themes.dart';
import 'package:fitnessappv2/providers/calory_provider.dart';
import 'package:fitnessappv2/providers/distance_provider.dart';
import 'package:fitnessappv2/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:fitnessappv2/Providers/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DistanceProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CaloryProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(), // Added ThemeProvider
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Fitness Api',
            debugShowCheckedModeBanner: false,
            theme: themeProvider.isDarkMode ? CustomThemes.getDarkTheme() : CustomThemes.getLightTheme(),
            routes: {
              '/login': (context) => const LoginScreen(),
              //'/signup': (context) => SignupScreen(),
            },
            home: const LoginScreen(),
          );
        },
      ),
    );
  }
}

final ThemeData _lightTheme = ThemeData(
  primaryColor: const Color.fromARGB(255, 255, 255, 255),
  secondaryHeaderColor: const Color.fromARGB(255, 122, 122, 122),
  scaffoldBackgroundColor: const Color.fromARGB(255, 0, 0, 0),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: const Color.fromARGB(255, 145, 96, 96),
  ),
  primarySwatch: Colors.orange,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color.fromRGBO(44, 44, 44, 1),
    unselectedItemColor: Color.fromARGB(255, 122, 122, 122),
    selectedItemColor: Color.fromARGB(255, 255, 255, 255),
  ),
  textTheme: ThemeData.light().textTheme.apply(
    bodyColor: Colors.white,
    displayColor: Colors.white,
  ),
);

