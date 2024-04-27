import 'package:fitnessappv2/models/statistics_model.dart';

class UserList {
  String title;
  List<Statistic> items;

  UserList({
    required this.title,
    required this.items,
  });

  factory UserList.fromJson(Map<String, dynamic> json) {
    List<Statistic> statisticList = [];
    for (var item in json['statistics']) {
      statisticList.add(Statistic.fromJson(item));
    }

    return UserList(
      title: json['title'],
      items: statisticList,
    );
  }
}
