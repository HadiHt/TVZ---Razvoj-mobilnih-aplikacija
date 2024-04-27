import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitnessappv2/models/user_model.dart' as User;
import 'dart:convert';
import 'package:crypto/crypto.dart';

const String USER_COLLECTION_REF = "Users";
final _fireStore = FirebaseFirestore.instance;

class DatabaseService {
  //late final CollectionReference _userRef;

  DatabaseService() {
    // _userRef = _fireStore.collection(USER_COLLECTION_REF).withConverter<User>(
    //     fromFirestore: (snapshots, _) => User.fromJson(
    //           snapshots.data()!,
    //         ),
    //     toFirestore: (user, _) => user.toJson());
  }

  // Stream<QuerySnapshot> getUsers() {
  //   _fireStore.collection(USER_COLLECTION_REF).get().then((event) {
  //     for (var doc in event.docs) {
  //       print("${doc.id} => ${doc.data()}");
  //     }
  //   });
  //   return _userRef.snapshots();
  // }

  String hashString(String string) {
    String hashedString = sha256.convert(utf8.encode(string)).toString();

    return hashedString;
  }

  Future<User.User> getUsers(User.User user) async {
    User.User fetchedUser =
        User.User(username: "", email: "", password: "");
    try {
      DocumentSnapshot ds = await _fireStore
          .collection(USER_COLLECTION_REF)
          .doc(hashString(user.email))
          .get();
      if (ds.exists) {
        Map<String, dynamic>? data = ds.data() as Map<String, dynamic>?;
        if (data != null) {
          if (data['password'] == user.password) {
            fetchedUser = User.User(
              username: data['username'] as String? ?? "",
              email: data['email'] as String? ?? "",
              password: data['password'] as String? ?? "",
            );
            print("Correct Email and Password");
          } else {
            print("Incorrect Password");
          }
        } else {
          print("Data is null!");
        }
      } else {
        print("Wrong Email!");
      }
    } catch (e) {
      print("Error getting user: $e");
      throw e;
    }
    return fetchedUser;
  }

  void addUser(User.User user) async {
    var userToAdd = <String, String>{
      "email": user.email,
      "password": user.password,
      "username": user.username
    };
    await _fireStore
        .collection(USER_COLLECTION_REF)
        .doc(hashString(user.email))
        .set(userToAdd, SetOptions(merge: true))
        .whenComplete(() => print("User Added"))
        .onError((error, stackTrace) => print("error saving to DB  $error "));
  }

  void resetDailyDistance(User.User user) async{
    final userDocRef = _fireStore.collection(USER_COLLECTION_REF).doc(hashString(user.email));
    DateTime today = DateTime.now();
    int formatedDate = int.parse(today.toString().split(" ")[0].replaceAll("-", ""));

    try {
      final userDocSnapshot = await userDocRef.get();
      if (userDocSnapshot.exists) {
        await userDocRef.update({'dailyDistance': formatedDate.toString()+'_0'});
      }
    }catch (error) {
      print("Failed to reset daily distance for ${user.email}: $error");
    }
  }
  void updateTotalDistance(User.User user, int distance) async {
    final userDocRef = _fireStore.collection(USER_COLLECTION_REF).doc(hashString(user.email));

    try {
      final userDocSnapshot = await userDocRef.get();
      if (userDocSnapshot.exists) {
        var userData = userDocSnapshot.data();
        String currentDailyDistance = userData != null && userData.containsKey('dailyDistance') ? userData['dailyDistance'] : "0_0";
        int currentTotalDistance = userData != null && userData.containsKey('totalDistance') ? userData['totalDistance'] : 0 ;
        int updatedTotalDistance = currentTotalDistance + distance;
        String updateDailyDistance = currentDailyDistance.split("_")[0]+"_"+(int.parse(currentDailyDistance.split("_")[1])+distance).toString();

        await userDocRef.update({'totalDistance': updatedTotalDistance});
        await userDocRef.update({'dailyDistance': updateDailyDistance});

        print("Distance updated successfully for ${user.email}");
      } else {
        print("User ${user.email} does not exist in the database.");
      }
    } catch (error) {
      print("Failed to update distance for ${user.email}: $error");
    }
  }
  Future<(int, String)?> getDistanceForUser(User.User user) async {
    DateTime today = DateTime.now();
    int formatedDate = int.parse(today.toString().split(" ")[0].replaceAll("-", ""));

    try {
      final userDocRef =
      await _fireStore.collection(USER_COLLECTION_REF).doc(
          hashString(user.email));
      final userDocSnapshot = await userDocRef.get();

      if (userDocSnapshot.exists) {
        Map<String, dynamic>? data = userDocSnapshot.data() as Map<String, dynamic>?;
        if (data is Map<String, dynamic> &&
            data.containsKey('totalDistance') && data.containsKey('dailyDistance')) {
          if(int.parse(data["dailyDistance"].toString().split("_")[0]) != formatedDate){
            data["dailyDistance"] = formatedDate.toString()+"_0";
            await userDocRef.update({'dailyDistance': data["dailyDistance"]});
            print("Daily Distance updated successfully for ${user.email}");
          }
          return (data['totalDistance'] as int, data["dailyDistance"] as String);
        }
      }
      return null;
    } catch (error) {
      print("Error fetching distance for user: $error");
      return null;
    }
  }
}
