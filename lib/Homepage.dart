import 'package:diettest2/pages/Home_page.dart';
import 'package:diettest2/pages/Profile_page.dart';
import 'package:diettest2/pages/Diet_page.dart';
import 'package:diettest2/sidebar/sidebar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'pages/workout_page.dart';


class Homepage extends StatefulWidget {
  Homepage({Key? key}) : super(key: key);


  @override
  State<Homepage> createState() => _HomepageState();
}
class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin{


  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref("userdetials");
  int _selectedTab = 0;
  final List<Widget> _pages = [
    const Home_page(),
    diet_page(),
    const Workout_page(),
    Profile_page(),
  ];
  // NotificationService notificationService = NotificationService();

  @override
  void initState(){
    super.initState();
    // notificationService.initialiseNotifications();
    // notification
  }
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        centerTitle: true,
        elevation: 1,
        title: const Text("Diet",
          style: TextStyle(
            color: Colors.white,
          fontSize: 25.0) ,
        ),
        backgroundColor: Colors.pink,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: Colors.white,
              size: 35,),
              onPressed: (){
                // notificationService.sendNotification(
                //     "This is reminded of water", "this ia daily SiteMinder");
              }
            )
        ],
      ),
      drawer: sidebar(),
      body: _pages[_selectedTab],
      bottomNavigationBar:
      SafeArea(
         child: Padding(
           padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 15),
           child: GNav(
             onTabChange:(_pages){
               setState(() {_selectedTab = _pages;});
               },
             tabs: const [
               GButton(
                 text: 'Home',
                 gap: 5,
                 icon: LineIcons.home,
                 iconColor: Colors.black,
                 iconActiveColor: Colors.pink,
                 textColor: Colors.pink,
                 iconSize: 24,
                 padding: EdgeInsets.symmetric(horizontal: 18,vertical: 5),
               ),
               GButton(
                 text: 'Meals',
                 gap: 5,
                 icon: LineIcons.utensils,
                 iconColor: Colors.black,
                 iconActiveColor: Colors.pink,
                 textColor: Colors.pink,
                 iconSize: 24,
                 padding: EdgeInsets.symmetric(horizontal: 18,vertical: 5),
               ),
               GButton(
                 icon: LineIcons.deployDog,
                 text: "Work Out",
                 iconColor: Colors.black,
                 iconActiveColor: Colors.pink,
                 textColor: Colors.pink,
                 iconSize: 24,
                 padding: EdgeInsets.symmetric(horizontal: 18,vertical: 5),),
               GButton(
                 icon: LineIcons.user,
                 text: "Profile",
                 iconColor: Colors.black,
                 iconActiveColor: Colors.pink,
                 textColor: Colors.pink,
                 iconSize: 24,
                 padding: EdgeInsets.symmetric(horizontal: 18,vertical: 5),
               ),
             ],
           ),
         )
      ),
    );
  }
}

