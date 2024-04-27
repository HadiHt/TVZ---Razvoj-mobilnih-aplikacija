class Distance {
  String dailyDistance;
  int totalDistance;

  Distance({
    required this.dailyDistance,
    required this.totalDistance
  });

  factory Distance.fromJson(Map<String, dynamic> json) {
    return Distance(
      dailyDistance: json['dailyDistance'],
      totalDistance: json['totalDistance'],
    );
  }
  toJson() {
    return {
      "dailyDistance": dailyDistance,
      "totalDistance": totalDistance
    };
  }
}
