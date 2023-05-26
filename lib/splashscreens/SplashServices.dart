import 'dart:async';
import 'package:diettest2/Homepage.dart';
import 'package:diettest2/models/session_manager.dart';
import 'package:diettest2/screens/loginscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashServices{
  void isLogin(BuildContext context){
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;


    if(user != null){
      SessionController().userId = user.uid.toString();
      Timer(const Duration(seconds: 2),
              () => Navigator.push(context, MaterialPageRoute(builder: (context)=> Homepage())));

    }
    else{
      Timer(const Duration(seconds: 2),
              () => Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginScreen())));

    }
  }
}