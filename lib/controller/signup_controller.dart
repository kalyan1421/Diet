import 'package:diettest2/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../screens/Details.dart';


class SignUpController with ChangeNotifier{
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref().child("users");
  bool _loading = false;
  bool get loading=> _loading;

  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }


  void signup(BuildContext context , String username , email , password) async{

    setLoading(true);

    try {
      auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      ).then((value) {

        ref.child(value.user!.uid.toString()).set({
        'uid' : value.user!.uid.toString(),
        'email': value.user!.email.toString(),
          'fullName': username
      }).then((value) {
        setLoading(true);
        Navigator.push(context ,MaterialPageRoute(builder: (context)=> DetialsScreen())
        );
      }).onError((error, stackTrace){
        setLoading(false);
        Utils.toasstMessage(error.toString());
      });

      }).onError((error, stackTrace) {
        setLoading(false);
        Utils.toasstMessage(error.toString());
      });
    }
    catch(e){
      Utils.toasstMessage(e.toString());
    }
  }




}