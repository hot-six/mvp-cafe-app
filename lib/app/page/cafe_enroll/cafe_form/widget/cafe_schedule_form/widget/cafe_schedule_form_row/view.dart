import 'package:flutter/material.dart';
import 'package:nado_client_mvp/app/core/values/colors.dart';
import 'package:nado_client_mvp/app/global_widgets/input.dart';

class CafeScheduleFormRow extends StatelessWidget {
  final String weekDayName;
  final Function onChangeStartTime;
  final Function onChangeEndTime;

  final TextEditingController startTimeController;
  final TextEditingController endTimeController;
  final bool isOpen;

  CafeScheduleFormRow({
    required this.weekDayName,
    required this.onChangeStartTime,
    required this.onChangeEndTime,
    required this.startTimeController,
    required this.endTimeController,
    required this.isOpen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: NadoColor.greyColor[100],
      child: Row(
        children: [
          Text(weekDayName,
              style: TextStyle(
                  color: isOpen == true ? Colors.black : NadoColor.greyColor,
                  fontSize: 16.0)),
          SizedBox(width: 14.0),
          Expanded(
            child: SquareInputField(
              textEditingController: startTimeController,
              hintText: '00:00',
              onChange: (string) {
                onChangeStartTime(string);
              },
              isEnable: isOpen,
            ),
          ),
          SizedBox(width: 14.0),
          Text('~', style: TextStyle(fontSize: 16.0)),
          SizedBox(width: 14.0),
          Expanded(
            child: SquareInputField(
              textEditingController: endTimeController,
              hintText: '00:00',
              onChange: (string) {
                onChangeEndTime(string);
              },
              isEnable: isOpen,
            ),
          ),
        ],
      ),
    );
  }
}
