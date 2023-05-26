import 'package:diettest2/splashscreens/SplashServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SplashScreen extends  StatefulWidget  {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class _SplashScreenState extends State<SplashScreen> {

  SplashServices splashscreen = SplashServices();

  @override
  void initState(){
    super.initState();
    splashscreen.isLogin(context);
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset("assets/AK_LOGO.png", scale: 1),
      ),
    );
  }
}
