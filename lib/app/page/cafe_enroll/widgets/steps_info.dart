import 'package:flutter/material.dart';
import 'package:nado_client_mvp/app/core/values/colors.dart';

class EnrollStepInfo extends StatelessWidget {
  final int step;

  EnrollStepInfo({required this.step});

  Widget stepCircle(int number) {
    return Container(
      width: 24.0,
      height: 24.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: NadoColor.greyColor[200],
      ),
      child: number < step
          ? Image.asset('assets/images/3.0x/check_filled_primary.png')
          : Text(
              '$number',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
      alignment: Alignment.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        stepCircle(1),
        SizedBox(width: 8.0),
        Image.asset(
          'assets/images/dot_line.png',
          color: step >= 2 ? NadoColor.primary : NadoColor.greyColor[200],
        ),
        SizedBox(width: 8.0),
        stepCircle(2),
        SizedBox(width: 8.0),
        Image.asset(
          'assets/images/dot_line.png',
          color: step >= 3 ? NadoColor.primary : NadoColor.greyColor[200],
        ),
        SizedBox(width: 8.0),
        stepCircle(3),
      ],
    );
  }
}
