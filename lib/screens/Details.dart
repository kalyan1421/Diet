import 'package:diettest2/Homepage.dart';
import 'package:diettest2/screens/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetialsScreen extends StatefulWidget {
  DetialsScreen({Key? key,}) : super(key: key);

  @override
  State<DetialsScreen> createState() => _DetialsScreenState();
}


class _DetialsScreenState extends State<DetialsScreen> {

  final auth = FirebaseAuth.instance;
  bool loading = false;
  final fullnameController = TextEditingController();
  final ageController = TextEditingController();
  final hieghtController = TextEditingController();
  final weightController = TextEditingController();
  var result = '';late double bmr, bmrpregnant;
  late int calories, BMRtotal, bmi, Fatcalories;late String Waterintake;
  List<bool> isSelected = [true, false, false];
  final formKey = GlobalKey<FormState>();
  List<String> items = <String>["Sedentary", "Light", "Moderately", "Heavy", "Athlete"];
  String ActivityValue = "Light";
  List<String> genderitems = <String>["Male", "Female", "Other"];
  String gendervalue = 'Male';
  List<String> mecicalconitems = <String>["None", "PCOD", "Diabetes Type 1", "Diabetes Type 2", "Cholesterol", "Pregnancy"];
  String mecicalconvalue = "None";
  List<String> goalitems = <String>["Lose Weight", "Maintain Weight", "Gain Weight"];
  String goalvalue = 'Maintain Weight';
  List<String> spemecicalconitems = <String>["None", "1-12 weeks", "13-26 weeks", "27-40 weeks",];
  String spemecicalconvalue = "None";

  late double caloriesDouble, doublebmi;
  final DatabaseReference userdetails = FirebaseDatabase.instance.ref(
      "userdetails");
  final databaseref = FirebaseDatabase.instance.ref("userdetials");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Details')),
        body: Container(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(height: 15),

                TextFormField(
                  style: GoogleFonts.poppins(fontSize: 15),
                  controller: ageController, keyboardType: TextInputType.number,
                  validator: (value) {if (value!.isEmpty) {return 'Please enter your Age';}return null;},
                  maxLength: 2,
                  decoration: const InputDecoration(labelText: "Age",
                    prefixIcon: Icon(Icons.account_box),
                    prefixIconColor: Colors.black,
                  ),),
                const SizedBox(height: 15),
                TextFormField(
                  style: GoogleFonts.poppins(fontSize: 15),
                  controller: hieghtController, keyboardType: TextInputType.number,
                  validator: (value) {if (value!.isEmpty) {return 'Please enter your Hieght';}return null;}, maxLength: 3,
                  decoration: const InputDecoration(labelText: "Hieght", prefixIcon: Icon(Icons.account_circle_outlined),
                    prefixIconColor: Colors.black,
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  style: GoogleFonts.poppins(fontSize: 15), controller: weightController, keyboardType: TextInputType.number,
                  validator: (value) {if (value!.isEmpty) {return 'Please enter your Weight';}return null;},maxLength: 2,
                  decoration: const InputDecoration(labelText: "Weight",
                    prefixIcon: Icon(Icons.account_circle_outlined),
                    prefixIconColor: Colors.black,),),
                Row(
                  children: [
                    Text(
                      "Activity:", style: GoogleFonts.poppins(fontSize: 20),),
                    const SizedBox(width: 30.0,),
                    DropdownButton<String>(
                      value: ActivityValue,
                      dropdownColor: Colors.blue.shade50,
                      onChanged: (String? newValue) {
                        setState(() {
                          ActivityValue = newValue!;
                        });
                      },
                      items: items.map<DropdownMenuItem<String>>((
                          String value) {
                        return DropdownMenuItem<String>(
                            child: Text(
                              value, style: GoogleFonts.poppins(fontSize: 20),),
                            value: value);
                      }).toList(),),],),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Text("Gender:", style: GoogleFonts.poppins(fontSize: 20)),
                    const SizedBox(width: 30.0,),
                    DropdownButton<String>(value: gendervalue,
                      dropdownColor: Colors.blue.shade50,
                      onChanged: (String? newValue) {
                        setState(() {
                          gendervalue = newValue!;
                        });
                      },
                      items: genderitems.map<DropdownMenuItem<String>>((
                          String value) {
                        return DropdownMenuItem<String>(child: Text(
                            value, style: GoogleFonts.poppins(fontSize: 20)),
                            value: value);
                      }).toList(),),],),
                const SizedBox(height: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Any Medical Condition we should be aware of :",
                        style: GoogleFonts.poppins(fontSize: 20)),
                    const SizedBox(height: 5.0,),
                    Padding(padding: const EdgeInsets.only(left: 8.0),
                      child: DropdownButton<String>(
                        dropdownColor: Colors.blue.shade50,
                        value: mecicalconvalue,
                        onChanged: (String? newValue) {
                          setState(() {
                            mecicalconvalue = newValue!;
                          });
                        },
                        items: mecicalconitems.map<DropdownMenuItem<String>>((
                            String value) {
                          return DropdownMenuItem<String>(child: Text(
                              value, style: GoogleFonts.poppins(fontSize: 20)),
                              value: value);
                        }).toList(),),),],),
                const SizedBox(height: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Specific condition",
                        style: GoogleFonts.poppins(fontSize: 20)),
                    const SizedBox(height: 5.0,),
                    Padding(padding: const EdgeInsets.only(left: 8.0),
                      child: DropdownButton<String>(
                        dropdownColor: Colors.blue.shade50,
                        value: spemecicalconvalue,
                        onChanged: (String? newValue) {
                          setState(() {
                            spemecicalconvalue = newValue!;
                          });
                        },
                        items: spemecicalconitems.map<
                            DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(child: Text(
                              value, style: GoogleFonts.poppins(fontSize: 20)),
                              value: value);
                        }).toList(),),),],),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Goal in your mind",
                        style: GoogleFonts.poppins(fontSize: 20)),
                    const SizedBox(height: 5.0,),
                    Padding(padding: const EdgeInsets.only(left: 8.0),
                      child: DropdownButton<String>(
                        dropdownColor: Colors.blue.shade50,
                        value: goalvalue,
                        onChanged: (String? newValue) {
                          setState(() {
                            goalvalue = newValue!;
                          });
                        },
                        items: goalitems.map<DropdownMenuItem<String>>((
                            String value) {
                          return DropdownMenuItem<String>(child: Text(
                              value, style: GoogleFonts.poppins(fontSize: 20)),
                              value: value);
                        }).toList(),),),],),
                const SizedBox(height: 15),
                const SizedBox(height: 15),
                RoundButton(
                    title: "NEXT", loading: loading,
                    ontap: () async {
                      final isValidFrom = formKey.currentState!.validate();
                      var wt = weightController.text.toString();
                      var iwt = int.parse(wt);
                      var ft = hieghtController.text.toString();
                      var ift = int.parse(ft);
                      var age = ageController.text.toString();
                      var iage = int.parse(age);
                      setState(() {
                        if (iwt != '' && ift != '' && iage != '') {
                          if (gendervalue == "Male") {
                            bmr = (88.362 + (13.397 * iwt) + (4.799 * ift) - (5.677 * iage));}
                          else if (gendervalue == "Female") {bmr = (447.593 + (9.247 * iwt) + (3.098 * ift) - (4.330 * iage));}
                          else if (gendervalue == "Other") {bmr = (88.362 + (13.397 * iwt) + (4.799 * ift) - (5.677 * iage));}
                        }
                        int bmrTotal = (bmr.round());

                        if (ActivityValue == "Sedentary" || ActivityValue == "Light") {
                          caloriesDouble = (bmrTotal * 1.375);
                        }
                        else if (ActivityValue == "Moderately") {
                          caloriesDouble = (bmrTotal * 1.375);
                        } else if (ActivityValue == "Heavy") {
                          caloriesDouble = (bmrTotal * 1.55);
                        } else if (ActivityValue == "Athlete") {
                          caloriesDouble = (bmrTotal * 1.9);
                        }
                        double hieghtmeter = ift / 100;
                        doublebmi = (iwt / (hieghtmeter * hieghtmeter));
                        bmi = (doublebmi.round());
                        double water = (iwt / 30);
                        Waterintake = water.toStringAsFixed(2);
                        calories = (caloriesDouble.round());
                        BMRtotal = bmrTotal;
                      });
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Homepage()));
                      setState(() {
                        loading = true;
                      });
                      User? user = FirebaseAuth.instance.currentUser;
                      String? uid = user?.uid;
                      int dt = DateTime
                          .now()
                          .millisecondsSinceEpoch;
                      DatabaseReference ref = FirebaseDatabase.instance.ref()
                          .child("userdetails");
                      ref.child(user!.uid.toString()).set({
                        "UID": uid,
                        "Data": dt,
                        "age": ageController.text.toString(),
                        "height": hieghtController.text.toString(),
                        "weight": weightController.text.toString(),
                        "bmr": BMRtotal,
                        "bmi": bmi,
                        "calories": calories,
                        "Activity": ActivityValue.toString(),
                        "gender": gendervalue.toString(),
                        "condition": mecicalconvalue.toString(),
                        "goal": goalvalue.toString(),
                        "waterintake": Waterintake.toString(),
                        "Specifcondition": spemecicalconvalue.toString()
                      });
                      setState(() {
                        loading = false;
                      });
                    }),],),),));}}



