import 'package:flutter/material.dart';
import 'package:nado_client_mvp/app/core/values/colors.dart';

class CafeAccuracyDialog extends StatelessWidget {
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
      title: Text.rich(
        TextSpan(children: [
          TextSpan(text: '선택한 유형과 카페의\n'),
          TextSpan(
            text: '일치 정도',
            style: TextStyle(
              color: NadoColor.primary,
            ),
          ),
          TextSpan(text: '를 알려주는 지표입니다.'),
        ]),
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Wrap(
        children: [
          Column(
            children: [
              SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  accuracyUnit(1, '0 ~ 25%'),
                  accuracyUnit(2, '25 ~ 50%'),
                  accuracyUnit(3, '50 ~ 75%'),
                  accuracyUnit(4, '75 ~ 100%'),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget accuracyUnit(int accuracyIndex, String text) {
    return Column(
      children: [
        Image.asset('assets/images/accuracy_${accuracyIndex}.png'),
        SizedBox(height: 11.0),
        Text(
          text,
          style: TextStyle(fontSize: 12.0),
        ),
      ],
    );
  }
}
