import 'package:fitnessappv2/screens/workoutdetails_screen.dart';
import 'package:flutter/material.dart';
class WorkoutProgramScreen extends StatefulWidget {
  const WorkoutProgramScreen({Key? key}) : super(key: key);

  @override
  _WorkoutProgramScreenState createState() => _WorkoutProgramScreenState();
}

class _WorkoutProgramScreenState extends State<WorkoutProgramScreen> {
  List<String> imageUrls = [
    'assets/images/Biceps.jpg',
    'assets/images/Triceps.jpg',
    'assets/images/Chests.jpg',
    'assets/images/Backs.jpg',
    'assets/images/Shoulders.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout Program'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WorkoutDetailsScreen(imageIndex: index)),
              );
            },
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    '${imageUrls[index]}',
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
