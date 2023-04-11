import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nado_client_mvp/app/core/values/colors.dart';

class CeoNoticeInfoDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: EdgeInsets.only(
        left: 27.0,
        right: 27.0,
        bottom: 19.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16.0),
        ),
      ),
      title: Text(
        '안내',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
      content: Container(
        width: 320,
        child: Text(
          "나도손님 서비스는 현재 베타 서비스입니다.\n\n사장님 서비스는 나도손님이 만든\n임의 카페에 대해서만 정보 수정 가능합니다.\n\n실제 정보 수정이 필요할 경우\n우측 상단의 ‘평가해주세요'를 클릭해 주세요.",
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.normal,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      actions: [
        InkWell(
          onTap: () {
            Get.back();
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 15.0),
            decoration: BoxDecoration(
              color: NadoColor.greyColor[500],
              borderRadius: BorderRadius.circular(100.0),
            ),
            child: Text(
              '확인',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
