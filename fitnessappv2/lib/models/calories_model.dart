import 'package:flutter/widgets.dart';

class Calory {
  double calory;

  Calory({
    required this.calory
  });


  toJson() {
    return {
      "calory": calory
    };
  }
}
