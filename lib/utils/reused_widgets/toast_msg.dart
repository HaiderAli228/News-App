import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news/resources/app_color.dart';

class ToastMsg{
  toastMsgIs(String msgIs){
    return Fluttertoast.showToast(
        msg: msgIs,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.themeColor,
        textColor: Colors.white,
        fontSize: 18.0
    ) ;
  }
}