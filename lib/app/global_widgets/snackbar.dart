import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nado_client_mvp/app/core/values/colors.dart';

class NoticeSnackBar {
  static void defaultSnackBar({
    required String content,
  }) {
    Get.snackbar(
      '',
      '',
      titleText: Text(
        content,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      padding: EdgeInsets.only(top: 14.0),
      messageText: SizedBox(height: 10.0),
      backgroundColor: NadoColor.greyColor[500],
      borderRadius: 100.0,
      boxShadows: [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.25),
          offset: Offset(0, 4.0),
          blurRadius: 8.0,
        ),
      ],
      snackPosition: SnackPosition.BOTTOM,
      forwardAnimationCurve: Curves.easeIn,
      reverseAnimationCurve: Curves.easeOut,
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
    );
  }
}
