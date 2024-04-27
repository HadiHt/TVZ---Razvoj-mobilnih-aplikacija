
import 'package:fitnessappv2/models/calories_model.dart';
import 'package:fitnessappv2/services/calory_calculator_service.dart';

import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/distance_model.dart';

class CaloryProvider extends ChangeNotifier {
  Calory calory = Calory(calory: 0.0);

  Future<void> getBurn(BuildContext context) async {
    try {
      final CaloryCalculator caloryService = CaloryCalculator(context);
      calory.calory =caloryService.calculateBurn();
      notifyListeners();
    } catch (Ex) {
      print("Exception in GetBurn method: $Ex");
    }
  }
}
