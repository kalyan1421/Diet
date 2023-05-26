import 'package:diettest2/models/session_manager.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


class User {
  final String name;
  final String email;

  User({required this.name, required this.email});
}

final userdetails = FirebaseDatabase.instance.ref("userdetails").child(SessionController().userId.toString());
//
// Future<User> getUserData() async {
//   final snapshot = await userdetails.once();
//   Map<String, dynamic> data = snapshot.value;
//   return User(
//     name: data['name'],
//     email: data['email'],
//   );
// }
// Stream<User> getUserDataStream() {
//   return userdetails.child("user").onValue.map((event) {
//     Map<dynamic, dynamic>? data = event.snapshot.value as Map?;
//       return User(
//         name: data!['name'],
//         email: data['email'],
//       );
//   });
// }
//
// ------//////////////////
// class Userdetails {
//   late String uid;
//   late String accbmr;
//   late int dt;
//
//   Userdetails({
//     required this.uid,
//     required this.accbmr,
//     required this.dt,
//   });
//
//   factory Userdetails.fromJson(Map<dynamic, dynamic> json) {
//     double parser(dynamic source) {
//       try {
//         return double.parse(source.toString());
//       } on FormatException {
//         return -1;
//       }
//     }
//   // Userdetails.fromSnapshot(DataSnapshot snapshot):
//       // accbmr = snapshot.value!["bmr"].toString();
//
//   // toJson(){
//   //
//   // }
//
//     return Userdetails(
//       uid: parser(json['uid']).toString(),
//       accbmr: parser(json['accbmr']).toString(),
//       dt: parser(json['dt']).toInt(),
//     );
//   }
//
//
//
// }
