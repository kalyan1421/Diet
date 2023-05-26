import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/session_manager.dart';

class Basic_information extends StatefulWidget {
  const Basic_information({Key? key}) : super(key: key);

  @override
  State<Basic_information> createState() => _Basic_informationState();
}
class _Basic_informationState extends State<Basic_information> {
  final users = FirebaseDatabase.instance.ref("users").child(SessionController().userId.toString());
  final userdetails = FirebaseDatabase.instance.ref("userdetails").child(SessionController().userId.toString());


  @override
  Widget build(BuildContext context) {
    final  height = MediaQuery.of(context).size.height;
    final  width = MediaQuery.of(context).size.width;
    return Stack(
      fit: StackFit.expand,
      children: [
        Scaffold(
            backgroundColor: Colors.blueGrey[50],
            appBar:
            AppBar(
                toolbarHeight: 50, centerTitle: true, elevation: 1,
                title: Text("Basic Information", style: GoogleFonts.abel(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white) ,),
                backgroundColor:
                Colors.pink[300]
            ),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget> [
                  const SizedBox(height: 10,),
                  //--------------------------------FULL NAME
                  Padding(
                    padding:  const EdgeInsets.all(6.0),
                    child: Row(
                      children: [
                        StreamBuilder(
                            stream: userdetails.onValue,
                            builder: (context, AsyncSnapshot snapshot){
                              if(snapshot.hasData){
                                var gender = snapshot.data.snapshot.value["gender"];
                                if(gender == "Male"){return Image.asset("assets/male_icons.png",width: 43,height: 43,);}
                                else{return Image.asset("assets/female_icon.png",width: 38,height: 38,);}
                              }
                              else{return const Text("Loading");}
                            }),
                        const SizedBox(width: 8,),
                        Container(width: width/1.23, height: 68,
                          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),color: Colors.white70),
                          child: Padding(padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(padding: EdgeInsets.only(left: 5),
                                    child: Text("Full name" ,style: TextStyle(fontSize: 12),),),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 2.0,top: 1),
                                    child: StreamBuilder(
                                        stream: users.onValue,builder: (context, AsyncSnapshot snapshot){
                                          if(snapshot.hasData) {
                                            var name = snapshot.data.snapshot.value["fullName"];
                                            return Text("$name", style: GoogleFonts.abel(fontWeight: FontWeight.bold, fontSize: 22,color: Colors.black54),);
                                          }
                                          else{return Text("Loading",style: GoogleFonts.abel(fontWeight: FontWeight.bold, fontSize: 5),);}}
                                    ),
                                  )
                                ]),
                          ),
                        )
                      ],
                    ),
                  ),
                  //--------------------------------GENDER
                  Padding(
                    padding:  const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.asset("assets/icons8-gender-equality-96.png",scale: 2.2,),
                        const SizedBox(width: 10,),
                        StreamBuilder(
                            stream: userdetails.onValue,builder: (context, AsyncSnapshot snapshot){
                          if(snapshot.hasData) {
                            var gender = snapshot.data.snapshot.value["gender"];
                            if(gender == "Male"){
                              return Row(
                                children: [
                                  Container(width: width/3.5, height: 40,
                                      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),color: Colors.lightBlue),
                                      child: Center(child: Text("Male",style: GoogleFonts.abel(fontWeight: FontWeight.bold, fontSize: 30,color: Colors.white),),)
                                  ),
                                  const SizedBox(width: 10,),
                                  Container(width: width/3.5, height: 40,
                                      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),color: Colors.white70),
                                      child: Center(child: Text("Female",style: GoogleFonts.abel(fontWeight: FontWeight.bold, fontSize: 30,color: Colors.pinkAccent),),)
                                  )
                                ],
                              );
                            }
                            else{
                              return Row(
                                children: [
                                  Container(width: width/3.5, height: 40,
                                      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),color: Colors.white),
                                      child: Center(child: Text("Male",style: GoogleFonts.abel(fontWeight: FontWeight.bold, fontSize: 30,color: Colors.blue),),)
                                  ),
                                  const SizedBox(width: 10,),
                                  Container(width: width/3.5, height: 40,
                                      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),color: Colors.pinkAccent),
                                      child: Center(child: Text("Female",style: GoogleFonts.abel(fontWeight: FontWeight.bold, fontSize: 30,color: Colors.white),),)
                                  )
                                ],
                              );
                            }
                          }
                          else{return Text("Loading",style: GoogleFonts.abel(fontWeight: FontWeight.bold, fontSize: 5),);}}
                        ),
                      ],
                    ),
                  ),
                  //--------------------------------EMAIL
                  Padding(
                    padding:  const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.asset("assets/icons8-envelope-96.png",scale: 2.2,),
                        const SizedBox(width: 10,),
                        Container(width: width/1.23, height: 68,
                          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),color: Colors.white70),
                          child: Padding(padding: const EdgeInsets.all(10.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(padding: EdgeInsets.only(left: 5),
                                    child: Text("Email" ,style: TextStyle(fontSize: 12),),),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0,top: 2),
                                    child: StreamBuilder(
                                        stream: users.onValue,builder: (context, AsyncSnapshot snapshot){
                                      if(snapshot.hasData) {
                                        var email = snapshot.data.snapshot.value["email"];
                                        return Text("$email", style: GoogleFonts.abel(fontWeight: FontWeight.bold, fontSize: 22,color: Colors.black54),);
                                      }
                                      else{return Text("Loading",style: GoogleFonts.abel(fontWeight: FontWeight.bold, fontSize: 5),);}}
                                    ),
                                  )
                                ]),
                          ),
                        )
                      ],
                    ),
                  ),
                  //--------------------------------AGE
                  Padding(
                    padding:  const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.asset("assets/icons8-birthday-cake-80.png",scale: 1.8,),
                        const SizedBox(width: 10,),
                        Container(width: width/1.23, height: 68,
                          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),color: Colors.white70),
                          child: Padding(padding: const EdgeInsets.all(10.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(padding: EdgeInsets.only(left: 5),
                                    child: Text("Age( in years)" ,style: TextStyle(fontSize: 12),),),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0,top: 2),
                                    child: StreamBuilder(
                                        stream: userdetails.onValue,builder: (context, AsyncSnapshot snapshot){
                                      if(snapshot.hasData) {
                                        var age = snapshot.data.snapshot.value["age"];
                                        return Text("$age", style: GoogleFonts.abel(fontWeight: FontWeight.bold, fontSize: 22,color: Colors.black54),);
                                      }
                                      else{return Text("Loading",style: GoogleFonts.abel(fontWeight: FontWeight.bold, fontSize: 5),);}}
                                    ),
                                  )
                                ]),
                          ),
                        )
                      ],
                    ),
                  ),
                  //--------------------------------Daily Activity
                  Padding(
                    padding:  const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.asset("assets/icons8-running-shoe-96.png",scale: 2.3,),
                        const SizedBox(width: 10,),
                        Container(width: width/1.23, height: 68,
                          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),color: Colors.white70),
                          child: Padding(padding: const EdgeInsets.all(10.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(padding: EdgeInsets.only(left: 5),
                                    child: Text("Daily Activity" ,style: TextStyle(fontSize: 12),),),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0,top: 2),
                                    child: StreamBuilder(
                                        stream: userdetails.onValue,builder: (context, AsyncSnapshot snapshot){
                                      if(snapshot.hasData) {
                                        var Activity = snapshot.data.snapshot.value["Activity"];
                                        return Text("$Activity", style: GoogleFonts.abel(fontWeight: FontWeight.bold, fontSize: 22,color: Colors.black54),);
                                      }
                                      else{return Text("Loading",style: GoogleFonts.abel(fontWeight: FontWeight.bold, fontSize: 5),);}}
                                    ),
                                  )
                                ]),
                          ),
                        )
                      ],
                    ),
                  ),
                  //--------------------------------HEIGHT
                  Padding(
                    padding:  const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.asset("assets/icons8-straight-ruler-96.png",scale: 2.2,),
                        const SizedBox(width: 10,),
                        Container(width: width/1.23, height: 68,
                          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),color: Colors.white70),
                          child: Padding(padding: const EdgeInsets.all(10.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(padding: EdgeInsets.only(left: 5),
                                    child: Text("Height" ,style: TextStyle(fontSize: 12),),),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0,top: 2),
                                    child: StreamBuilder(
                                        stream: userdetails.onValue,builder: (context, AsyncSnapshot snapshot){
                                      if(snapshot.hasData) {
                                        var height = snapshot.data.snapshot.value["height"];
                                        return Text("$height cms", style: GoogleFonts.abel(fontWeight: FontWeight.bold, fontSize: 22,color: Colors.black54),);
                                      }
                                      else{return Text("Loading",style: GoogleFonts.abel(fontWeight: FontWeight.bold, fontSize: 5),);}}
                                    ),
                                  )
                                ]),
                          ),
                        )
                      ],
                    ),
                  ),
                  //--------------------------------WEIGHT
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        children: [
                          Image.asset("assets/icons8-weight-64.png",scale: 1.45,),
                          const SizedBox(width: 10,),
                          Container(width: width/1.23, height: 68,
                            decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),color: Colors.white70),
                            child: Padding(padding: const EdgeInsets.all(10.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(padding: EdgeInsets.only(left: 5),
                                      child: Text("Current Weight" ,style: TextStyle(fontSize: 12),),),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5.0,top: 2),
                                      child: StreamBuilder(
                                          stream: userdetails.onValue,builder: (context, AsyncSnapshot snapshot){
                                        if(snapshot.hasData) {
                                          var Weight = snapshot.data.snapshot.value["weight"];
                                          return Text("$Weight kgs", style: GoogleFonts.abel(fontWeight: FontWeight.bold, fontSize: 22,color: Colors.black54),);
                                        }
                                        else{return Text("Loading",style: GoogleFonts.abel(fontWeight: FontWeight.bold, fontSize: 5),);}}
                                      ),
                                    )
                                  ]),
                            ),
                          )
                        ],
                      ),
                  ),
                  //--------------------------------BMI
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.asset("assets/icons8-bmi-96.png",scale: 2.2,),
                        const SizedBox(width: 10,),
                        Container(width: width/1.23, height: 68,
                          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),color: Colors.white70),
                          child: Padding(padding: const EdgeInsets.all(10.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(padding: EdgeInsets.only(left: 5),
                                    child: Text("BMI" ,style: TextStyle(fontSize: 12),),),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0,top: 2),
                                    child: StreamBuilder(
                                        stream: userdetails.onValue,builder: (context, AsyncSnapshot snapshot){
                                      if(snapshot.hasData) {
                                        var bmi = snapshot.data.snapshot.value["bmi"];
                                        return Text("$bmi", style: GoogleFonts.abel(fontWeight: FontWeight.bold, fontSize: 22,color: Colors.black54),);
                                      }
                                      else{return Text("Loading",style: GoogleFonts.abel(fontWeight: FontWeight.bold, fontSize: 5),);}}
                                    ),
                                  )
                                ]),
                          ),
                        )
                      ],
                    ),
                  ),
                  //--------------------------------MEDICAL CONDITION
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.asset("assets/icons8-stethoscope-96.png",scale: 2.2,),
                        const SizedBox(width: 10,),
                        Container(width: width/1.23, height: 68,
                          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),color: Colors.white70),
                          child: Padding(padding: const EdgeInsets.all(10.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(padding: EdgeInsets.only(left: 5),
                                    child: Text("Medical Conditions" ,style: TextStyle(fontSize: 12),),),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0,top: 2),
                                    child: StreamBuilder(
                                        stream: userdetails.onValue,builder: (context, AsyncSnapshot snapshot){
                                      if(snapshot.hasData) {
                                        var Conditions = snapshot.data.snapshot.value["condition"];
                                        return Text("$Conditions", style: GoogleFonts.abel(fontWeight: FontWeight.bold, fontSize: 22,color: Colors.black54),);
                                      }
                                      else{return Text("Loading",style: GoogleFonts.abel(fontWeight: FontWeight.bold, fontSize: 5),);}}
                                    ),
                                  )
                                ]),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(left: 20),
                    child: Text("Any medical issue we should know about?"),),
                  const SizedBox(height: 20,),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 10.0),
                  //   child: Row(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text("Specific condition" , style: GoogleFonts.abel(fontWeight: FontWeight.bold, fontSize: 22,color: Colors.black),),
                  //       // const SizedBox(width: 15.0,),
                  //       Padding(padding: const EdgeInsets.only(left: 20.0),
                  //         child: DropdownButton<String>(
                  //           focusColor:Colors.white,
                  //           style: const TextStyle(color: Colors.pinkAccent),
                  //           dropdownColor: Colors.blue.shade50,
                  //           value: mecicalconvalue,
                  //           onChanged: (String? newValue){setState(() {mecicalconvalue = newValue!;});},
                  //           items: mecicalconitems.map<DropdownMenuItem<String>>((String value){
                  //             return DropdownMenuItem<String>(child: Text(value , style:  GoogleFonts.poppins(fontSize: 20)),value: value);}).toList(),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  //-------------------------------LOCATION
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.asset("assets/icons8-user-location-96.png",scale: 2.2,),
                        const SizedBox(width: 10,),
                        Container(width: width/1.23, height: 68,
                          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),color: Colors.white70),
                          child: Padding(padding: const EdgeInsets.all(10.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(padding: EdgeInsets.only(left: 5),
                                    child: Text("Location" ,style: TextStyle(fontSize: 12),),),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0,top: 2),
                                    child:  Text("India", style: GoogleFonts.abel(fontWeight: FontWeight.bold, fontSize: 22,color: Colors.black54),)
                                  )
                                ]),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,)

                ],
              ),)
        ),
        ],
    );
  }
}
