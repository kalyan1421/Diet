// import 'package:firebase_auth/firebase_auth.dart';
// import 'onAuthStateChanged';
// class AuthService{
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   Stream<String> get onAuthStateChanged =>
//       _auth.onAuthStateChanged.map(
//           (FirebaseUser user) => user?.uid,
//       );
//
//   Future<String> createUserWithEmailAndPassword(String emai)
//
//   Future<String> getCurrentUID() async {
//     return (await _auth.currentUser!).uid;
//   }
//   signOut() {
//     return _auth.signOut();
//   }
// }
