import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class DataController extends GetxController{


  final FirebaseAuth _auth = FirebaseAuth.instance;

  DocumentSnapshot? myDocument;

  getMyDocument(){
  }
}