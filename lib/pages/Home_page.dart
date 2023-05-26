import 'package:animations/animations.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:diettest2/Profile_screens_page/Tracker_page.dart';
import 'package:diettest2/Profile_screens_page/goal_screen.dart';
import 'package:diettest2/pages/Diet_page.dart';
import 'package:diettest2/models/session_manager.dart';
import 'package:diettest2/pages/workout_page.dart';
import 'package:diettest2/screens/Track_steps.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Profile_screens_page/Track_WORKOUT.dart';
import '../models/meal.dart';
import '../models/theme.dart';
import '../models/workoutlist.dart';
import '../utils/radial_progress.dart';
import 'package:line_icons/line_icons.dart';
import '../screens/recipe_details.dart';
import '../water_pages/water_intake.dart';
class Home_page extends StatefulWidget {
  const Home_page({Key? key}) : super(key: key);

  @override
  State<Home_page> createState() => _Home_pageState();

}
class _Home_pageState extends State<Home_page> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final  DatabaseReference ref11= FirebaseDatabase.instance.ref("users");
  DatabaseReference userdetails = FirebaseDatabase.instance.ref("userdetails");
  final userdetails1 = FirebaseDatabase.instance.ref("userdetails").child(SessionController().userId.toString());

  @override
  Widget build(BuildContext context) {
    final  height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],

      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ListView(

            children: <Widget>[
              const SizedBox(height: 10.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Calender(),
                  // Divider(thickness: 2,color: Colors.pink.shade300,),
                  Row(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(_greetingMessage,style: GoogleFonts.abel(fontWeight: FontWeight.bold, fontSize: 20),),
                      const SizedBox(width: 1,),
                      displayusername(),
                    ],
                  ),
                  const SizedBox(height: 3,),
                  // Calories CARD----------------------------------------------

                  Card(
                    shape: RoundedRectangleBorder(side: BorderSide(color: Colors.pink.shade100,),
                        borderRadius: BorderRadius.circular(10.0)),
                    clipBehavior: Clip.antiAlias, shadowColor: Colors.pink[200], elevation: 5.0,
                    child: Row(
                      children: [
                        Flexible(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                ListTile(
                                  title: const Text('Calories', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black)),
                                  subtitle: Text('Remaining = Goal-Food+Exercise', style: TextStyle(color: Colors.black.withOpacity(0.8)),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: RadialProgress(),
                                ),
                              ]
                            ),
                          ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              CardsProgress(),
                              const SizedBox(height: 10,),
                              FatProgress(),
                              const SizedBox(height: 10,),
                              ProteinProgress()
                            ],
                          ),
                        ],
                      ),
                  ),
                  //Balanced Diet ----------------------------------------------

                  SizedBox(
                    height: height*0.08,
                    width: width,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child:
                          Row(
                            children: [
                              Text("Balanced Diet", style: headingStyle,),
                              const SizedBox(width: 5,),
                              Container(
                                margin: const EdgeInsets.all(5.0),
                                child: RaisedButton(
                                  color: Colors.pinkAccent,
                                  shape:  const StadiumBorder(),
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const diet_page()));},
                                  child: Row(
                                    children: const [
                                      Text("Edit", style: TextStyle(fontSize: 18.0, color: Colors.white),),
                                      SizedBox(width: 2,),
                                      Icon(Icons.edit,size: 18.0,)],),),
                              ),
                              SizedBox(
                                // margin: EdgeInsets.all(10.0),
                                width: 90,
                                height: 40,
                                child: RaisedButton(
                                  color: Colors.pinkAccent,
                                  shape:  const StadiumBorder(),
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>  const Goal_page()));},

                                  child: Row(
                                    // mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Text("Goal", style: TextStyle(fontSize: 18.0, color: Colors.white),),
                                      ImageIcon( AssetImage("images/icongoal.png"),size: 10.0,)
                                    ],),),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0 , bottom: 10.0),
                    child:
                    Text("Tracker Now" , style: GoogleFonts.breeSerif(fontSize: 22, color: Colors.pink[300]),
                    ),
                  ),
                  //TRACKER CARDs-----------------------------------------------

                  Trackerbox(),
                  //Recipes ----------------------------------------------------

                  SizedBox(
                    height: height*0.40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8, left: 32, right: 16),
                          child: Text("Recipes for You",
                            style: TextStyle(color: Colors.blueGrey, fontSize: 20, fontWeight: FontWeight.w700),),),
                        const SizedBox(height: 10,),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                const SizedBox(width: 20.0),
                                for(int i =0;i<meals.length;i++)
                                  _MealCard(
                                    meal: meals[i],
                                  ),
                                // }
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0,),
                  Text("Today's Work Out" , style: GoogleFonts.breeSerif(fontSize: 22, color: Colors.pink[300])),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(width: width, height: 150, decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(10.0)),),
                    ],
                  ),
                  const SizedBox(height: 15.0,),
                ]
              ),
            ],
          ),
        ),
    );
  }
}
class  ProteinProgress extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Protein".toUpperCase(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700,),),
          Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Stack(children: <Widget>[
                  Container(height: 10, width: width*0.28,decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)), color: Colors.black12,),),
                  Container(height: 10, width: width * 0.05, decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)), color: Colors.green,),),
            ],
            ),
                const SizedBox(width: 10,),
                Userprotein(),
          ]
        )
      ]
    );
  }
}
class  CardsProgress extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text("CARDS", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700,),),
          Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Stack(children: <Widget>[
                  Container(height: 10, width: width*0.28,decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)), color: Colors.black12,),),
                  Container(height: 10, width: width * 0.15, decoration: const BoxDecoration(borderRadius:  BorderRadius.all(Radius.circular(5)), color: Colors.purple,),),
                ],
                ),
                const SizedBox(width: 10,),
                usercards(),
              ]
          )
        ]
    );
  }
}
class  FatProgress extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text("FATS", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700,),),
          Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Stack(children: <Widget>[
                  Container(height: 10, width: width*0.28,decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)), color: Colors.black12,),),
                  Container(height: 10, width: width * 0.1, decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)), color: Colors.redAccent,),),
                ],
                ),
                const SizedBox(width: 10,),
                userfat(),
              ]
          )
        ]
    );
  }
}
class _MealCard extends StatelessWidget {
  final Meal meal;

  const _MealCard({ Key? key, required this.meal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        right: 20,
        bottom: 20,
      ),
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              child: OpenContainer(
                closedShape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                transitionDuration: const Duration(milliseconds: 500),
                openBuilder: (context, _) {
                  return MealDetailScreen1(meal: meal,);
                    // MealDetailScreen(meal: meal,);
                  
                },
                closedBuilder: (context, openContainer) {
                  return GestureDetector(
                    onTap: openContainer,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Image.asset(
                        meal.imagePath,
                        width: 150,
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: 5),
                    Text(
                      meal.mealTime,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.blueGrey,
                      ),
                    ),
                    Text(
                      meal.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "${meal.kiloCaloriesBurnt} kcal",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.blueGrey,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        const Icon(Icons.access_time, size: 15, color: Colors.black12,),
                        const SizedBox(width: 4,),
                        Text(
                          "${meal.timeTaken} min",
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class Calender extends StatelessWidget {
  Calender({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width =MediaQuery.of(context).size.width;
    final hieght =MediaQuery.of(context).size.height;
    return Container(
        child: DatePicker(
          DateTime.now(), height: 80, width: 60, initialSelectedDate: DateTime.now(), selectionColor: Colors.pink, selectedTextColor: Colors.white, dateTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black12)),
          dayTextStyle: GoogleFonts.lato(
              textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black12)
          ),
          monthTextStyle: GoogleFonts.lato(
              textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black12)),
          onDateChange: (date){},),
    );
  }
}
class displayusername extends StatefulWidget {
  @override
  State<displayusername> createState() => _displayusernameState();
}
class _displayusernameState extends State<displayusername> {
  final ref1 =FirebaseDatabase.instance.ref("users");

  String _greetingMessage = '';

  @override
  void initState() {
    super.initState();
    _getGreeting();
  }

  void _getGreeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      setState(() {
        _greetingMessage = 'Good morning';
      });
    } else if (hour < 15) {
      setState(() {
        _greetingMessage = 'Good afternoon';
      });
    } else if (hour < 20) {
      setState(() {
        _greetingMessage = 'Good evening';
      });
    } else {
      setState(() {
        _greetingMessage = 'Good night';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child:
      StreamBuilder(
          stream: ref1.child(SessionController().userId.toString()).onValue,
          builder: (context, AsyncSnapshot snapshot){
           if(snapshot.hasData && snapshot.data != null){
             String name = snapshot.data.snapshot.value["fullName"];
             String capname = name.capitalize!;
             return Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text(_greetingMessage,style: GoogleFonts.abel(fontWeight: FontWeight.bold, fontSize: 20)),
                 Row(
                   children: [
                     Text("Hi $capname", style: GoogleFonts.abel(fontWeight: FontWeight.bold, fontSize: 23),),
                     // SizedBox(width: 3,),
                     Image.asset("assets/icons8-waving-hand-emoji-96.png",scale: 3,),
                   ],
                 ),
               ],
             );
           }
            else{
               return const Center(child: Text("Loading"),);}
          }
      ),
    );
  }
}
class Trackerbox extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final width =MediaQuery.of(context).size.width;
    late int watercounter = 0;
    late int waterafter =0;
    final height= MediaQuery.of(context).size.height;
    final userdetails = FirebaseDatabase.instance.ref("userdetails").child(SessionController().userId.toString());
    return Container(
        width: width,
        height: height/1.8,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0) ,topRight: Radius.circular(20.0)),
          color: Colors.transparent,
        ),
        child: Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8.0 , top: 2.0),
                  child: Column(
                    children: <Widget>[
                      //-------------------------------------Work Out Page
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                        child: Container(
                            width: width/2.3, height: width/2,
                            decoration: BoxDecoration(
                              boxShadow: [BoxShadow(color: Colors.pink.shade200.withOpacity(0.5),
                                spreadRadius: 0.2, blurRadius: 5, offset: Offset(0, 10),
                              ),],
                              borderRadius: BorderRadius.circular(15.0),color: Colors.white,

                            ),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: GestureDetector(
                                  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> Track_Page()));
                                  },
                                  child: Container(
                                    width: 90,height: 90,
                                    decoration:  const ShapeDecoration(color: Colors.transparent, shape: CircleBorder (
                                        side: BorderSide(width: 4, color: Colors.pink)),
                                    ),
                                    child:  Center(
                                      child:
                                      // Image.asset('images/run.png' ,),
                                      Icon(LineIcons.running, size: 60, color: Colors.pink[300],),
                                      ),
                                  ),
                                )

                              ),
                              const SizedBox(height: 20.0,),
                              Text("Burn At Least" , style: GoogleFonts.breeSerif(fontSize: 18, color: Colors.pink[300]),),
                              Text("542 Cal" , style: GoogleFonts.breeSerif(fontSize: 15, color: Colors.pink[300]),)
                            ],
                          )
                        ),
                      ),
                      const SizedBox(height: 10.0,),
                      //--------------------------------------WATER PAGE
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                        child: Container(width: width/2.2, height: width/2, decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(color: Colors.blue.shade200.withOpacity(0.5),
                              spreadRadius: 0.2, blurRadius: 5, offset: Offset(0, 10),
                            )],
                              // spreadRadius: 0.2, blurRadius: 5, offset: Offset(0, 10),
                            // ),
                            borderRadius: BorderRadius.circular(15.0),color: Colors.white),
                          child:
                            StreamBuilder(stream: userdetails.onValue, builder: (context, AsyncSnapshot snapshot) {
                              if(snapshot.hasData) {
                                dynamic Activity = snapshot.data.snapshot.value['Activity'];
                                dynamic weight = snapshot.data.snapshot.value['weight'];
                                int iweight = int.parse(weight);
                                dynamic waterintake = (iweight/30).toStringAsFixed(2);
                                int iwaterintake = int.parse(waterintake.replaceAll(RegExp(r'[^0-9]'),''));
                                if (Activity == 'Sedentary' || Activity == "Light") {
                                  int normalwaterintake = (iwaterintake * 10 + 500) as int;
                                  dynamic cups = (normalwaterintake/250).toStringAsFixed(0);
                                  return Column(
                                    children: [
                                      const SizedBox(height: 20,),
                                      Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const SizedBox(width: 5,),
                                            GestureDetector(
                                              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> water_intake()));},
                                              child: Container(width: 90,height: 90,
                                                decoration: const ShapeDecoration(color: Colors.transparent, shape: CircleBorder (side: BorderSide(width: 4, color: Colors.blue))),
                                                child: Center(
                                                  child:Icon(Icons.local_drink, size: 45, color: Colors.blue.shade300,),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 5,),
                                          ]),
                                      const SizedBox(height: 5,),
                                      Text("Drink $cups glasses\n"
                                          "         of water" , style: GoogleFonts.breeSerif(fontSize: 18, color: Colors.blue[200],)
                                      ),
                                    ],
                                  );
                                }
                                else if (Activity == "Moderately" || Activity == "Heavy") {
                                  int normalwaterintake = (iwaterintake * 10 + 1000) as int;
                                  dynamic cups = (normalwaterintake / 250).toStringAsFixed(0);
                                  return Column(
                                    children: [
                                      const SizedBox(height: 20,),
                                      Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const  SizedBox(width: 5,),
                                            GestureDetector(
                                              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> water_intake()));},
                                              child: Container(width: 70,height: 70,
                                                decoration: const ShapeDecoration(color: Colors.transparent, shape: CircleBorder (side: BorderSide(width: 4, color: Colors.blue))),
                                                child: Center(
                                                  child:Icon(Icons.local_drink, size: 45, color: Colors.blue.shade300,),
                                                ),
                                              ),
                                            ),
                                             const SizedBox(width: 5,),
                                          ]),
                                      const SizedBox(height: 25,),
                                      Text("Drink $cups glasses\n"
                                          "         of water" , style: GoogleFonts.breeSerif(fontSize: 15, color: Colors.blue[200],)
                                      ),
                                    ],
                                  );
                                }
                              }
                              return const Text("Loading");
                            })
                        ),
                      ),
                    ]
                  ),
                )
              ]
            ),
            Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0 , top: 5.0),
                    child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                            child: Container(width: width/2.3, height: width/2,
                                decoration: BoxDecoration(
                                    boxShadow: [BoxShadow(color: Colors.pink.shade200.withOpacity(0.5),
                                      spreadRadius: 0.2, blurRadius: 5, offset: Offset(0, 10),
                                    ),],
                                    borderRadius: BorderRadius.circular(15.0),color: Colors.white
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                        padding: const EdgeInsets.only(top: 45.0),
                                        child: GestureDetector(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=> Track_steps()));
                                          },
                                            child: Stack(
                                              children: [
                                                const Icon(Icons.square, size: 60,color: Colors.transparent,),
                                                Positioned(top: 0, left: 0, child: Image.asset('assets/icons8-google-fit-48.png', width: 30, height: 30),),
                                                Positioned(top: 0, right: 0, child: Image.asset('assets/icons8-heart-health-96.png', width: 30, height: 30),),
                                                Positioned(bottom: 0, left: 0, child: Image.asset('assets/icons8-samsung-health-96.png', width: 30, height: 30),),
                                                Positioned(bottom: 0, right: 0, child: Image.asset('assets/icons8-fitbit-96.png', width: 30, height: 30),),
                                              ],
                                            ))
                                    ),
                                    const SizedBox(height: 20.0,),
                                    Text("Track Your steps" , style: GoogleFonts.breeSerif(fontSize: 18, color: Colors.pink[300]),),
                                    Text("Connect Now" , style: GoogleFonts.breeSerif(fontSize: 15, color: Colors.pink[300]),)
                                  ],
                                )
                            ),
                          ),
                          const SizedBox(height: 10.0,),
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0, top: 5.0),
                            child: Container(
                                width: width/2.3, height: width/2, decoration: BoxDecoration(
                                boxShadow: [BoxShadow(color: Colors.blue.shade200.withOpacity(0.5),
                                  spreadRadius: 0.2, blurRadius: 5, offset: Offset(0, 10),
                                ),],
                                borderRadius: BorderRadius.circular(15.0),color: Colors.white),
                                child: GestureDetector(
                                  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> const Track_Page()));},
                                  child: Center(
                                    child: Text("View All\n"
                                        "Tracker" , style: GoogleFonts.breeSerif(fontSize: 18, color: Colors.blue[200]),),
                                  ),
                                )
                            ),
                          ),
                        ]
                    ),
                  )
                ]
            )
          ]
        )
    );
  }
}
class bmr extends StatelessWidget {
  final ref1 = FirebaseDatabase.instance.ref("userdetails").child(SessionController().userId.toString());
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: ref1.onValue,
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Text("Loading");
          }
          else if (snapshot.hasData && snapshot.data != null) {
            var bmr = snapshot.data.snapshot.value['bmr'];
            return Text("$bmr", style: const TextStyle(fontSize: 14.0, letterSpacing: 1.5, fontWeight: FontWeight.bold),);
          }
          else {
            return const Center(child: Text("Loading"),);
          }
        }
    );
  }
}
class usercalories extends StatelessWidget {
  final ref1 = FirebaseDatabase.instance.ref("userdetails").child(SessionController().userId.toString());

  usercalories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: ref1.onValue,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            var usercalories = snapshot.data.snapshot.value['calories'];
            return Text("$usercalories", style: const TextStyle(fontSize: 14.0, letterSpacing: 1.5, fontWeight: FontWeight.bold),);
          }
          else{
            return const Text("Loading " ,style: TextStyle(fontSize: 14.0, letterSpacing: 1.5, fontWeight: FontWeight.bold));
          }
        }
    );
  }
}
class Userprotein extends StatelessWidget{
  final userdetails = FirebaseDatabase.instance.ref("userdetails").child(SessionController().userId.toString());
   Userprotein({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: userdetails.onValue,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.hasData){
          var calories = snapshot.data.snapshot.value['calories'];
          double protein = (calories*0.15)/4;
          return Text("${protein.round()}g left  ", );
        }
        return const Text("Loading");
      },
    );
  }
}
class usercards extends StatelessWidget{
  final userdetails = FirebaseDatabase.instance.ref("userdetails").child(SessionController().userId.toString());
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: userdetails.onValue,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.hasData){
          var calories = snapshot.data.snapshot.value['calories'];
          double cards = (calories*0.65)/4;
          return Text("${cards.round()}g left  ", );
        }
        return Text("Loading");
      },
    );
  }

}
class userfat extends StatelessWidget{
  final userdetails = FirebaseDatabase.instance.ref("userdetails").child(SessionController().userId.toString());
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: userdetails.onValue,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.hasData){
          var calories = snapshot.data.snapshot.value['calories'];
          double fat = (calories*0.25)/4;
          return Text("${fat.round()}g left  ", );
        }
        return const Text("Loading");
      },
    );
  }
}
class BMI extends StatelessWidget{
  final userdetails = FirebaseDatabase.instance.ref("userdetails").child(SessionController().userId.toString());
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: userdetails.onValue,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            dynamic BMI = snapshot.data.snapshot.value['bmi'];
            if(BMI<=18.5){
              return Text("You are Underweight\n"
                  "Your BMI is $BMI");
            }
            else if(BMI<=25.0){
              return Text("You are 	Healthy Weight\n"
                  "Your BMI is $BMI");
            }
            else if(BMI<=30.0){
              return Text("You are Overweight\n"
                  "Your BMI is $BMI");
            }
            else{
              return Text("You are Obesity\n"
                  "Your BMI is $BMI");
            }
          }
          return const Text("Loading");
        });
  }

}
class waterintake extends StatelessWidget{
  final userdetails = FirebaseDatabase.instance.ref("userdetails").child(SessionController().userId.toString());
  late int waterintakeint;
  @override
  Widget build(BuildContext context) {
    return
      StreamBuilder(
        stream: userdetails.onValue,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
             dynamic Activity = snapshot.data.snapshot.value['Activity'];
             dynamic weight = snapshot.data.snapshot.value['weight'];
             int iweight = int.parse(weight);
             dynamic waterintake = (iweight/30).toStringAsFixed(2);
             int iwaterintake = int.parse(waterintake.replaceAll(RegExp(r'[^0-9]'),''));
             if(Activity == 'Sedentary' || Activity =="Light")
             {
               int normalwaterintake = (iwaterintake*10+500);
               dynamic cups =(normalwaterintake/250).toStringAsFixed(0);
               return Text("$normalwaterintake mill lites $cups cups(250ml per cup) " , style: GoogleFonts.breeSerif(fontSize: 18, color: Colors.blue[200],));
             }
             else if(Activity== "Moderately" || Activity =="Heavy" )
             {
               int normalwaterintake = (iwaterintake*10+1000) as int;
               dynamic cups =(normalwaterintake/250).toStringAsFixed(0);
               return Text("$normalwaterintake mill lites $cups cups(250ml per cup)" , style: GoogleFonts.breeSerif(fontSize: 18, color: Colors.blue[200],));
             }
          }
          return Text("Loading",style: GoogleFonts.breeSerif(fontSize: 18, color: Colors.blue.shade200));
        });
  }
}
