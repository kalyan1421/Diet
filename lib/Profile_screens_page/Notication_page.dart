import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Notification_page extends StatefulWidget {
  const Notification_page({Key? key}) : super(key: key);

  @override
  State<Notification_page> createState() => _Notification_pageState();
}

class _Notification_pageState extends State<Notification_page> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(child: Text("notification"))
    );
  }
}

