
import 'package:fitnessappv2/services/database_service.dart';
import 'package:flutter/cupertino.dart';

import '../models/user_model.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


//import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider extends ChangeNotifier {
  var db = FirebaseFirestore.instance;
  final DatabaseService dbService = DatabaseService();
  User user = User(username: "", email: "", password: "");
  Future<void> getAuth(User user) async {
    try {
      this.user = await dbService.getUsers(user);
      notifyListeners();
    } catch (Ex) {
      print("Exception in GetAuth method: $Ex");
      throw Ex;
    }
  }

  User getUser() {
    return user;
  }

  void getUserInfo() async {
    final user = <String, dynamic>{
      "email": "Ada",
      "password": "Lovelace",
      "username": "1815"
    };
    db.collection("users").add(user).then((DocumentReference doc) =>
        print('DocumentSnapshot added with ID: ${doc.id}'));
    //  var firebaseUser = await FirebaseAuth.instance.currentUser();
    //  print();
    //return new User(username: "username", email: "email", password: "password");
  }
}
