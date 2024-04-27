
import 'package:fitnessappv2/models/user_model.dart';
import 'package:fitnessappv2/services/database_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/distance_model.dart';

class DistanceProvider extends ChangeNotifier {
  var db = FirebaseFirestore.instance;
  final DatabaseService dbService = DatabaseService();
  Distance distance = Distance(dailyDistance: "",totalDistance: 0);
  Future<void> getDistance(User user) async {
    try {
      DateTime today = DateTime.now();
      String formatedDate = today.toString().split(" ")[0].replaceAll("-", "");
      var (totalDistance, dailyDistance) = (await dbService.getDistanceForUser(user) ?? (0, formatedDate+'_0'))!;
      this.distance.totalDistance = totalDistance;
      this.distance.dailyDistance = dailyDistance;

      notifyListeners();
    } catch (Ex) {
      print("Exception in GetDistance method: $Ex");
    }
  }
}
