import 'package:flutter/material.dart';


class Utils{
  void toastMessage(String message){
    // Fluttertoast.showToast(
    //   msg: message,
    //   toastLength: Toast.LENGTH_SHORT,
    //   gravity: ToastGravity.BOTTOM,
    //   timeInSecForIosWeb: 1,
    //   backgroundColor: Colors.red,
    //   textColor: Colors.white,
    //   fontSize: 16.0
    // );
  }
  static void fieldFoucs(BuildContext context, FocusNode currentNode, FocusNode nextFocus){
    currentNode.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static toasstMessage(String message){
    // Fluttertoast.showToast(
    //     msg: message,
    //     backgroundColor: Colors.black12,
    //     textColor: Colors.white,
    //   fontSize: 14
    // );
  }
}