import 'dart:math';
import 'package:fitnessappv2/Providers/auth_provider.dart';
import 'package:fitnessappv2/providers/distance_provider.dart';
import 'package:fitnessappv2/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ThemeData _lightButtonTheme = ThemeData(
    primaryColor: Colors.black12,
    textTheme: ThemeData.light().textTheme.apply(
      bodyColor: Colors.grey,
    ),
  );

  final DatabaseService dbService = DatabaseService();
  LocationData? _previousLocation;
  User user = new User(username: "", email: "", password: "");
  int _totalDistance = 0;
  String _dailyDistance = "_";
  int _dailyDistanceInt = 0;

  @override
  void initState() {
    user = Provider.of<AuthProvider>(context, listen: false).user;
    Provider.of<DistanceProvider>(context, listen: false).getDistance(user).then((value) =>{
    _totalDistance = Provider.of<DistanceProvider>(context, listen: false).distance.totalDistance,
    _dailyDistance = Provider.of<DistanceProvider>(context, listen: false).distance.dailyDistance,
    _dailyDistanceInt = int.parse(_dailyDistance.split("_")[1])
    });

    super.initState();
    _startLocationTracking();
  }

  Future<void> _startLocationTracking() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();

    location.onLocationChanged.listen((LocationData currentLocation) {
      if (_previousLocation != null) {
        int distanceInMeters = _calculateDistance(
            _previousLocation!.latitude!,
            _previousLocation!.longitude!,
            currentLocation.latitude!,
            currentLocation.longitude!).toInt();
        setState(() {
          _totalDistance += distanceInMeters;
          _dailyDistanceInt += distanceInMeters;
          if (_dailyDistanceInt > 10000) {
            _dailyDistanceInt = 10000;
          }
          dbService.updateTotalDistance(user, distanceInMeters);
        });
      }
      _previousLocation = currentLocation;
    });
  }

  double _calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    const R = 6371000;
    double latDistance = radians(lat2 - lat1);
    double lonDistance = radians(lon2 - lon1);
    double a = pow(sin(latDistance / 2), 2) +
        cos(radians(lat1)) * cos(radians(lat2)) * pow(sin(lonDistance / 2), 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = R * c;
    return distance;
  }

  double radians(double degree) {
    return degree * (pi / 180);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Distance Tracker'),
      ),
      body: FutureBuilder(
        key: UniqueKey(),
        future: Provider.of<DistanceProvider>(context, listen: false).getDistance(user),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            print("snapshot Error");
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Total Distance: $_totalDistance meters',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    'Daily Distance: $_dailyDistanceInt meters',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  const SizedBox(height: 20.0),
                  Theme(
                    data: _lightButtonTheme,
                    child: ElevatedButton(
                      onPressed: () {
                        // Reset daily distance
                        setState(() {
                          _dailyDistanceInt = 0;
                        });
                      },
                      child: const Text('Reset Daily Distance'),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
