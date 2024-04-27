import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitnessappv2/models/user_model.dart' as User;
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:fitnessappv2/providers/distance_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class CaloryCalculator {
  int totalDistance = 0;
  double totalBurn = 0.0;
  double walkingMET = 3.5;
  CaloryCalculator(BuildContext context) {
    totalDistance = Provider.of<DistanceProvider>(context, listen: false).distance.totalDistance;
  }
  double calculateBurn(){
    DateTime now = DateTime.now();
    totalBurn = (walkingMET * 70 /60) * (now.hour*60+now.minute) * (totalDistance/1000);
    return totalBurn;
  }

}
