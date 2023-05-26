import 'package:diettest2/Profile_screens_page/Basic_information.dart';
import 'package:diettest2/Profile_screens_page/Food_recpies_page.dart';
import 'package:diettest2/Profile_screens_page/Health_blogs.dart';
import 'package:diettest2/Profile_screens_page/Notication_page.dart';
import 'package:diettest2/Profile_screens_page/Tracker_page.dart';
import 'package:diettest2/Profile_screens_page/goal_screen.dart';
import 'package:diettest2/models/session_manager.dart';
import 'package:diettest2/Profile_screens_page/Setting_page.dart';
import 'package:diettest2/pages/workout_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart';


class Profile_page extends StatefulWidget {
  Profile_page({Key? key}) : super(key: key);


  @override
  State<Profile_page> createState() => _Profile_pageState();
}

class _Profile_pageState extends State<Profile_page> {

  final refref =FirebaseDatabase.instance.ref("users");
  final ref1 = FirebaseDatabase.instance.ref("userdetails").child(SessionController().userId.toString());
  @override
  Widget build(BuildContext context) {
    final  height = MediaQuery.of(context).size.height;
    final  width = MediaQuery.of(context).size.width;
    return Stack(
      fit: StackFit.expand,
      children: [
        Scaffold(
          backgroundColor: Colors.blueGrey[50],
          body: SingleChildScrollView(
            child: Column(
                children: [
                  const SizedBox(height: 10.0,),
                  Container(
                    width: width,
                    height: 100.0,
                    color: Colors.blueGrey[50],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 15.0,),
                        Container(
                          width: 90,
                          height: 90,
                          decoration: const BoxDecoration(
                            color: Colors.white70,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: const Icon(Icons.person_rounded, size: 50,color: Colors.grey,),
                        ),
                        Padding(padding: EdgeInsets.only(top: 15, left: 20,bottom: 10),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            username(),
                            useremail(),
                            const SizedBox(height: 10,),
                            location(),
                          ],),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: width,
                      height: 300.0,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Colors.white,
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Basic_information()));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(width: 15.0,),
                                    Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: <Widget> [
                                      const Icon(Icons.person_rounded, size: 50,color: Colors.black
                                        ,),
                                      const SizedBox(width: 5,),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Basic Information",style: GoogleFonts.abel(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black)),
                                            const SizedBox(height: 5,),
                                            Text("Height , Weight , Age , Gender , Activity" ,style: GoogleFonts.abel(fontWeight: FontWeight.normal, fontSize: 15),),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  // ),
                                ),
                                  ],
                                ),),
                              const Divider(height: .5, thickness: 3,),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const Goal_page()));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(width: 15.0,),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        children: <Widget> [
                                          const Icon(Icons.flag, size: 50,color: Colors.black,),
                                          const SizedBox(width: 5,),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("Goals",style: GoogleFonts.abel(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black)),
                                                const SizedBox(height: 5,),
                                                StreamBuilder(
                                                    stream: ref1.onValue,
                                                    builder: (context, AsyncSnapshot snapshot){
                                                      if(snapshot.hasData){
                                                        var gender = snapshot.data.snapshot.value["goal"];
                                                        return Text("$gender",  style: GoogleFonts.abel(fontWeight: FontWeight.normal, fontSize: 15),
                                                        );
                                                      }
                                                      else{
                                                        return const Text("Loading"  , style: TextStyle(
                                                          color: Color.fromRGBO(39, 105, 171, 1),
                                                          fontFamily: 'Nunito',
                                                          fontSize: 10,
                                                        ),);
                                                      }
                                                    }
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      // ),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(height: 1, thickness: 3,),
                              GestureDetector(
                                onTap: (){
                                  // Navigator.push(context, MaterialPageRoute(builder: (context)=> const diet_page()));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(width: 15.0,),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        children: <Widget> [
                                          Icon(Icons.fastfood, size: 50,color: Colors.black,),
                                          const SizedBox(width: 5,),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("Food Prefernces",style: GoogleFonts.abel(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black)),
                                                const SizedBox(height: 5,),
                                                Text("Diet Prefernces, Oraganic" ,style: GoogleFonts.abel(fontWeight: FontWeight.normal, fontSize: 15),),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      // ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(width: width, height: height/2, decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)), color: Colors.white,),
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const Health_blog()));
                                },
                                child: Row(
                                  children: [
                                    const Icon(Icons.list_alt,size: 25,color: Colors.black,),
                                    const SizedBox(width: 15.0,),
                                    Text("Health Blogs",style: GoogleFonts.abel(fontWeight: FontWeight.w500, fontSize: 20, color: Colors.black) )
                                  ],
                                ),
                              ),
                              Container(height: 5, width: width, decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.blueGrey.shade50,),),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const Food_recpies()));
                                },
                                child: Row(
                                  children: [
                                    const Icon(Icons.set_meal_sharp,size: 25,color: Colors.black,),
                                    const SizedBox(width: 15.0,),
                                    Text("Food Recpies",style: GoogleFonts.abel(fontWeight: FontWeight.w500, fontSize: 20, color: Colors.black) )
                                  ],
                                ),
                              ),
                              Container(height: 5, width: width, decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.blueGrey.shade50,),),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const Workout_page()));
                                },
                                child: Row(
                                  children: [
                                    const Icon(Icons.fitness_center,size: 25,color: Colors.black,),
                                    const SizedBox(width: 15.0,),
                                    Text("Work Out Exercise",style: GoogleFonts.abel(fontWeight: FontWeight.w500, fontSize: 20, color: Colors.black) )
                                  ],
                                ),
                              ),
                              Container(height: 5, width: width, decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.blueGrey.shade50,),),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const Track_Page()));
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.track_changes,size: 20,color: Colors.black,),
                                    const SizedBox(width: 15.0,),
                                    Text("Track now",style: GoogleFonts.abel(fontWeight: FontWeight.w500, fontSize: 20, color: Colors.black) )
                                  ],
                                ),
                              ),
                              Container(height: 5, width: width, decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.blueGrey.shade50,),),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const Notification_page()));
                                },
                                child: Row(
                                  children: [
                                    const Icon(Icons.notifications,size: 20,color: Colors.black,),
                                    const SizedBox(width: 15.0,),
                                    Text("Notification",style: GoogleFonts.abel(fontWeight: FontWeight.w500, fontSize: 20, color: Colors.black) )
                                  ],
                                ),
                              ),
                              Container(height: 5, width: width, decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.blueGrey.shade50,),),
                              GestureDetector(
                                child: Row(
                                  children: [
                                    const Icon(Icons.help_outlined,size: 25,color: Colors.black,),
                                    const SizedBox(width: 15.0,),
                                    Text("Help & Support",style: GoogleFonts.abel(fontWeight: FontWeight.w500, fontSize: 20, color: Colors.black) )
                                  ],
                                ),
                              ),
                              Container(height: 5, width: width, decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.blueGrey.shade50,),),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const Setting_page()));
                                },
                                child: Row(
                                  children: [
                                    const Icon(Icons.settings,size: 25,color: Colors.black,),
                                    const SizedBox(width: 15.0,),
                                    Text("Setting ",style: GoogleFonts.abel(fontWeight: FontWeight.w500, fontSize: 20, color: Colors.black) )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                    ),
                  ),
                ],
            ),
          ),
        ),
      ],
    );

  }
}
class username extends StatelessWidget {
  final ref1 = FirebaseDatabase.instance.ref("users").child(SessionController().userId.toString());
  @override
  Widget build(BuildContext context) {
    return
      StreamBuilder(
          stream: ref1.onValue,builder: (context, AsyncSnapshot snapshot){
            if(snapshot.hasData){
              String name = snapshot.data.snapshot.value["fullName"];
              String capname = name.capitalize!;
              return Text("$capname", style: GoogleFonts.abel(fontWeight: FontWeight.bold, fontSize: 20),);
            }else {return Text("Loading",style: GoogleFonts.abel(fontWeight: FontWeight.bold, fontSize: 10),);}}
      );
  }
}
class useremail extends StatelessWidget {
  final ref1 = FirebaseDatabase.instance.ref("users").child(SessionController().userId.toString());
  @override
  Widget build(BuildContext context) {
    return
      StreamBuilder(
          stream: ref1.onValue,
          builder: (context, AsyncSnapshot snapshot){
            if(snapshot.hasData){
              var email = snapshot.data.snapshot.value["email"];
              return Text("$email" ,  style: GoogleFonts.abel(fontWeight: FontWeight.normal, fontSize: 15),);
            }
            else{return const Text("Loading",);
            }
          }
      );
  }
}
class userheight extends StatelessWidget {
  final ref1 = FirebaseDatabase.instance.ref("userdetails").child(SessionController().userId.toString());

  userheight({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return
      Container(
        child: StreamBuilder(
            stream: ref1.onValue,
            builder: (context, AsyncSnapshot snapshot){
              if(snapshot.hasData){
                var name = snapshot.data.snapshot.value["height"];
                return Text("Height: $name cms" ,  style: GoogleFonts.dotGothic16(
                fontSize: 20,
                    color: Colors.white
                )
                );
              }
              else{
                return const Text("Loading"  , style: TextStyle(
                  color: Color.fromRGBO(39, 105, 171, 1),
                  fontFamily: 'Nunito',
                  fontSize: 20,
                ),);
              }
            }
        ),
      );
  }
}
class userAge extends StatelessWidget {
  final ref1 = FirebaseDatabase.instance.ref("userdetails").child(SessionController().userId.toString());
  @override
  Widget build(BuildContext context) {
    return
      Container(
        child: StreamBuilder(
            stream: ref1.onValue,
            builder: (context, AsyncSnapshot snapshot){
              if(snapshot.hasData){
                var name = snapshot.data.snapshot.value["age"];
                return Text("Age: $name years" ,  style: GoogleFonts.dotGothic16(
                    fontSize: 20,
                    color: Colors.white
                )
                );
              }
              else{
                return Text("Loading"  , style: const TextStyle(
                  color: Color.fromRGBO(39, 105, 171, 1),
                  fontFamily: 'Nunito',
                  fontSize: 20,
                ),);
              }
            }
        ),
      );
  }
}
class userWeight extends StatelessWidget {
  final ref1 = FirebaseDatabase.instance.ref("userdetails").child(SessionController().userId.toString());
  @override
  Widget build(BuildContext context) {
    return
      Container(
        child: StreamBuilder(
            stream: ref1.onValue,
            builder: (context, AsyncSnapshot snapshot){
              if(snapshot.hasData){
                var name = snapshot.data.snapshot.value["weight"];
                return Text("Weight: $name Kg",  style: GoogleFonts.dotGothic16(
                    fontSize: 20,
                    color: Colors.white
                )
                );
              }
              else{
                return const Text("Loading"  , style: TextStyle(
                  color: Color.fromRGBO(39, 105, 171, 1),
                  fontFamily: 'Nunito',
                  fontSize: 20,
                ),);
              }
            }
        ),
      );
  }
}
class usergender extends StatelessWidget {
  final ref1 = FirebaseDatabase.instance.ref("userdetails").child(SessionController().userId.toString());
  @override
  Widget build(BuildContext context) {
    return
      StreamBuilder(
          stream: ref1.onValue,
          builder: (context, AsyncSnapshot snapshot){
            if(snapshot.hasData){
              var gender = snapshot.data.snapshot.value["gender"];
              return Text("Gender: $gender",  style: GoogleFonts.dotGothic16(
                  fontSize: 20,
                  color: Colors.white
              )
              );
            }
            else{
              return const Text("Loading"  , style: TextStyle(
                color: Color.fromRGBO(39, 105, 171, 1),
                fontFamily: 'Nunito',
                fontSize: 20,
              ),);
            }
          }
      );
  }
}

class location extends StatefulWidget {
  location({Key? key}) : super(key: key);


  @override
  State<location> createState() => _locationState();
}
class _locationState extends State<location> {
  String _subcity='';
  String _city='';
  String _street='';
  String place ='';



  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }



  Future<void> _getCurrentLocation() async{
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled
      return;
    }

    // Request permission to access the user's location
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permission to access location is denied
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // The user has previously denied permission and chose to never ask again
      return;
    }
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var placemarks = await placemarkFromCoordinates(
        position.latitude, position.longitude);
    var placemark = placemarks.first;
    setState(() {
      _city = placemark.locality!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _city == null
          ? const Text("Loading...")
          : Text("City: $_city india",style: GoogleFonts.abel(fontWeight: FontWeight.normal, fontSize: 15),),
    );
  }
}


