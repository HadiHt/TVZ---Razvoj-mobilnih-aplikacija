import 'dart:math';
import 'package:fitnessappv2/Providers/auth_provider.dart';
import 'package:fitnessappv2/providers/calory_provider.dart';
import 'package:fitnessappv2/providers/distance_provider.dart';
import 'package:fitnessappv2/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';

class CaloryScreen extends StatefulWidget {
  const CaloryScreen({super.key});

  @override
  _CaloryScreenState createState() => _CaloryScreenState();
}

class _CaloryScreenState extends State<CaloryScreen> {

  final DatabaseService dbService = DatabaseService();
  LocationData? _previousLocation;
  User user = new User(username: "", email: "", password: "");
  int _dailyCaloriesBurnt = 0;
  int _totalCaloriesBurnt = 0;

  @override
  void initState() {
    user = Provider.of<AuthProvider>(context, listen: false).user;
    Provider.of<CaloryProvider>(context, listen: false).getBurn(context).then((value) =>{
      _dailyCaloriesBurnt = int.parse((Provider.of<DistanceProvider>(context, listen: false).distance.dailyDistance).split("_")[1])
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calories Tracker'),
      ),
      body: FutureBuilder(
        key: UniqueKey(),
        future: Provider.of<DistanceProvider>(context, listen: false).getDistance(user),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Calories Burned Today: $_dailyCaloriesBurnt',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    'Total Calories Burned: $_totalCaloriesBurnt',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  const SizedBox(height: 20.0)
                ],
              ),
            );
        },
      ),
    );
  }
}
