import 'dart:ui';
import 'package:diettest2/screens/round_button.dart';
import 'package:diettest2/screens/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../Homepage.dart';
import '../utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  bool loading = false;
  final _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final auth = FirebaseAuth.instance;
  @override
  void dispose(){
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final  height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: ()async {
        SystemNavigator.pop();
        return true;
      },
    child: Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //         automaticallyImplyLeading: false,
      //         title: Text('Login'),
      //       ),
      body: SafeArea(
        child:
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 100,),
                      Image.asset("assets/AK_LOGO.png", scale: 2),
                      Stack(
                        children: [
                          Container(
                            width: width,height: 130,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                            ),
                          ),
                          Positioned(
                            top: 40,
                            left: 0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Welcome!',
                                    style:  GoogleFonts.abel(fontWeight: FontWeight.bold, fontSize: 35 ,color: Colors.blue,letterSpacing: 1)
                                ),
                                Text(
                                    'Sign in to continue',
                                    style:  GoogleFonts.abel(fontWeight: FontWeight.bold, fontSize: 25 ,color: Colors.blue)
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Form(
                        key: _formkey,
                        child: Column(
                            children: [
                              // const Text("Login" ,style: TextStyle( fontWeight: FontWeight.bold,color: Color(0xFF004581) ,fontSize: 50),),
                              // const Text("Create an account, It's free", style: TextStyle(fontSize: 15,)),
                              const SizedBox(height: 30,),
                              TextFormField(
                                focusNode: emailFocusNode,
                                keyboardType: TextInputType.emailAddress,
                                controller: emailController,
                                onFieldSubmitted: (Value){
                                  Utils.fieldFoucs(context, emailFocusNode, passwordFocusNode);
                                },
                                decoration: const InputDecoration(
                                  hintText: "Email",
                                  helperText: "Enter email e.g XX@gmail.com",
                                  prefixIcon: Icon(Icons.alternate_email),
                                  // border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
                                ),
                                validator: (value){
                                  if(value!.isEmpty){
                                    return 'Enter Email';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                controller: passwordController,
                                focusNode: passwordFocusNode,
                                obscureText: true,
                                onFieldSubmitted: (Value){

                                },
                                decoration: const InputDecoration(
                                  hintText: "Password",
                                  helperText: "Enter Password with minimum 5 characters",
                                  prefixIcon: Icon(Icons.lock_open),
                                  // border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
                                ),
                                validator: (value){
                                  if(value!.isEmpty){
                                    return 'Enter Password';
                                  }
                                  return null;
                                },
                              )
                            ]
                        ),
                      ),
                      const SizedBox(height: 15),
                      RoundButton(
                        loading: loading,
                        title: 'Continue' ,
                        ontap: () async{
                          var email = emailController.text.trim();
                          var password = passwordController.text.trim();
                          if( email.isEmpty || password.isEmpty ){
                            // show error toast
                            // Fluttertoast.showToast(msg: 'Please fill all fields');
                            return;
                          }
                          ProgressDialog progressDialog = ProgressDialog(
                              context,
                              type: ProgressDialogType.Normal);
                          progressDialog.show();
                          try{
                            FirebaseAuth auth = FirebaseAuth.instance;
                            UserCredential userCredential =
                            await auth.signInWithEmailAndPassword(
                                email: email, password: password);
                            if( userCredential.user != null ){
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context){
                                    return Homepage();
                                  })
                              );
                            }
                          }
                          on FirebaseAuthException catch (e){
                            if( e.code == 'user-not-found'){

                              // Fluttertoast.showToast(msg: 'User not found');
                            }
                            else if( e.code == 'wrong-password'){
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //   Snackbar(
                              //   )
                              //
                              // )
                              // Fluttertoast.showToast(msg: 'Wrong password');
                            }
                          }
                          catch(e){
                            // Fluttertoast.showToast(msg: 'Something went wrong');
                          }},),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(onPressed: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context)=> SignupScreen())
                            );
                          },
                              child: Text("Don't have an account Sign Up" ,
                                  style: TextStyle(color: Colors.blue )))
                        ],
                      ),
                      // SizedBox(height: 200,),
                      Divider(color: Colors.blue,height: 5,thickness: 1,),
                      SizedBox(height: 35,),
                      SignInButton(
                        Buttons.Google,
                        onPressed: () {},
                      ),
                      SizedBox(height: 5,),
                      SignInButton(
                        Buttons.Apple,
                        onPressed: () {},
                      ),
                    ],
                  ),
                )
            ),

      ),
      )
    );
  }
}




