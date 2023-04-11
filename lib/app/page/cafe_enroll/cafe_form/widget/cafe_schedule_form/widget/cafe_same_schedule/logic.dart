import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nado_client_mvp/app/data/model/schedule.dart';

class SameCafeScheduleLogic extends GetxController {
  final List<CafeSchedule> cafeSchedule;

  late TextEditingController startTimeController;
  late TextEditingController endTimeController;

  SameCafeScheduleLogic({required this.cafeSchedule});

  @override
  void onInit() {
    super.onInit();
    startTimeController =
        TextEditingController(text: cafeSchedule[0].startTime);
    endTimeController = TextEditingController(text: cafeSchedule[0].startTime);
  }

  void onChangeStartTime(String timeString) {
    cafeSchedule.forEach((schedule) {
      schedule.startTime = timeString;
    });
  }

  void onChangeEndTime(String timeString) {
    cafeSchedule.forEach((schedule) {
      schedule.endTime = timeString;
    });
  }
}
