class Statistic {
  double walkingDistance;

  Statistic({required this.walkingDistance});

  factory Statistic.fromJson(Map<String, dynamic> json) {
    return Statistic(walkingDistance: json['walkingDistance'] ?? "");
  }
}

List<Statistic> statistics_list = [
  Statistic(
    walkingDistance: 1.1,
  ),
  Statistic(
    walkingDistance: 1.2,
  ),
  Statistic(
    walkingDistance: 1.3,
  )
];
