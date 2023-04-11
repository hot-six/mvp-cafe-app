import 'package:flutter/material.dart';
import 'package:nado_client_mvp/app/core/values/colors.dart';

class NextStepButton extends StatelessWidget {
  final Function onTapAction;
  final bool isDisabled;
  const NextStepButton({
    required this.onTapAction,
    required this.isDisabled,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => isDisabled ? null : onTapAction(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 116.0, vertical: 15.0),
        decoration: BoxDecoration(
          color:
              isDisabled ? NadoColor.greyColor[300] : NadoColor.greyColor[500],
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: Text(
          '다음',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
