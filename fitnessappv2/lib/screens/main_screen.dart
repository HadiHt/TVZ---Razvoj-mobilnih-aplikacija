import 'package:fitnessappv2/screens/settings_screen.dart';
import 'package:fitnessappv2/screens/statistics_screen.dart';
import 'package:fitnessappv2/screens/workoutprogram_screen.dart';
import 'package:fitnessappv2/screens/calory_screen.dart';
import 'package:fitnessappv2/screens/home_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentTab = 0;
  List<Widget> widgets = [
    const HomeScreen(),
    const CaloryScreen(),
    const WorkoutProgramScreen(),
    const StatisticsScreen(),
    const SettingsScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: widgets[currentTab],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black12,
          currentIndex: currentTab,
          onTap: (int value) {
            setState(() {
              currentTab = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
              backgroundColor: Colors.black12,
              icon: Icon(
                Icons.home,
                size: 30.0,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.black12,
              icon: Icon(
                Icons.no_food,
                size: 30.0,
              ),
              label: "Calories",
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.black12,
              icon: Icon(
                Icons.sports_football_outlined,
                size: 30.0,
              ),
              label: "Exercises",
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.black12,
              icon: Icon(
                Icons.newspaper_sharp,
                size: 30.0,
              ),
              label: "Statistics",
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.black12,
              icon: Icon(
                Icons.settings,
                size: 30.0,
              ),
              label: "Settings",
            ),
          ],
        ));
  }
}
