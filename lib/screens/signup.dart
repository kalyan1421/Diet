import 'package:diettest2/controller/signup_controller.dart';
import 'package:diettest2/screens/loginscreen.dart';
import 'package:diettest2/screens/round_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState  extends State<SignupScreen> {


  bool loading = false;
  final _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fullnameController = TextEditingController();
  final confirmController = TextEditingController();


  final emailFocusNode = FocusNode();
  final fullnameFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final confirmFocusNode = FocusNode();

  @override
  void dispose(){
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    fullnameController.dispose();
    confirmController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final  height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height*1;
    return Scaffold(
      backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: ChangeNotifierProvider(create: (_) => SignUpController(),
                child: Consumer<SignUpController>(
                    builder: (context , provider, child) {
                      return SingleChildScrollView(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 80,),
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
                                              'Sign up for continue',
                                              style:  GoogleFonts.abel(fontWeight: FontWeight.bold, fontSize: 25 ,color: Colors.blue)
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                // SizedBox(height: height*0.2,),
                                Form(
                                  key: _formkey,
                                  child: Column(
                                      children: [
                                        // Text("Sign up" ,style: const TextStyle(color: Color(0xFF004581) ,fontSize: 50 , fontWeight: FontWeight.bold),),
                                        // const Text("Create an account, It's free", style: TextStyle(fontSize: 15)),
                                        const SizedBox(height: 40),
                                        TextFormField(
                                          keyboardType: TextInputType.name,
                                          controller: fullnameController,
                                          decoration: const InputDecoration(
                                            hintText: "Full Name",
                                            helperText: "Enter Full name",
                                            prefixIcon: Icon(Icons.alternate_email),
                                            // border: OutlineInputBorder(borderRadius: BorderRadius.all(Ra    dius.circular(15.0))),
                                          ),
                                          validator: (value){
                                            if(value!.isEmpty){
                                              return 'Enter Email';
                                            }
                                            return null;
                                          },
                                        ),
                                        TextFormField(
                                          keyboardType: TextInputType.emailAddress,
                                          controller: emailController,
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
                                        const SizedBox(height: 10),
                                        TextFormField(
                                          controller: passwordController,
                                          obscureText: true,
                                          decoration: const InputDecoration(
                                            hintText: "Password",
                                            helperText: "Enter Password with minumum 5 characters",
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
                                  title: 'Sign Up' ,
                                  ontap: () async{
                                    if(_formkey.currentState!.validate()){
                                      provider.signup(context , fullnameController.text, emailController.text, passwordController.text);
                                    }
                                  },),
                                const SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                        onPressed: (){
                                          Navigator.push(context,MaterialPageRoute(builder: (context)=> LoginScreen()));},
                                        child: const
                                        Text("Have an account Login?",
                                            style: TextStyle(color: Color(0xFF004581)) ))
                                  ],
                                ),
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
                            )
                        ),
                      );
                    }
                    ),
              )
          )
        )
    );
  }
}