import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nado_client_mvp/app/data/model/schedule.dart';

class DifferentCafeScheduleLogic extends GetxController {
  final List<CafeSchedule> cafeSchedule;
  late List<Rx<CafeSchedule>> rxCafeSchedule = [];
  late List<RxBool> cafeScheduleToggleList = [];
  late List<TextEditingController> startTimeControllerList = [];
  late List<TextEditingController> endTimeControllerList = [];

  DifferentCafeScheduleLogic({required this.cafeSchedule});

  @override
  void onInit() {
    super.onInit();

    startTimeControllerList = cafeSchedule
        .map((schedule) => TextEditingController(text: schedule.startTime))
        .toList();
    endTimeControllerList = cafeSchedule
        .map((schedule) => TextEditingController(text: schedule.endTime))
        .toList();

    rxCafeSchedule = cafeSchedule.map((schedule) => schedule.obs).toList();
    cafeScheduleToggleList =
        cafeSchedule.map((schedule) => schedule.isOpen.obs).toList();
  }

  void onChangeIsOpen({
    required String weekdayName,
  }) {
    int scheduleIndex = cafeSchedule
        .indexWhere((schedule) => schedule.weekDayName == weekdayName);

    if (scheduleIndex != -1) {
      cafeSchedule[scheduleIndex].isOpen = !cafeSchedule[scheduleIndex].isOpen;
      cafeScheduleToggleList[scheduleIndex].value =
          cafeSchedule[scheduleIndex].isOpen;
    }

    if (cafeSchedule[scheduleIndex].isOpen == false) {
      cafeSchedule[scheduleIndex].startTime = '00:00';
      cafeSchedule[scheduleIndex].endTime = '00:00';
    } else {
      cafeSchedule[scheduleIndex].startTime =
          startTimeControllerList[scheduleIndex].text;
      cafeSchedule[scheduleIndex].endTime =
          endTimeControllerList[scheduleIndex].text;
    }
  }

  void onChangeStartTime({
    required String stringTime,
    required String weekdayName,
  }) {
    int scheduleIndex = cafeSchedule
        .indexWhere((schedule) => schedule.weekDayName == weekdayName);

    if (scheduleIndex != -1) cafeSchedule[scheduleIndex].startTime = stringTime;
  }

  void onChangeEndTime({
    required String stringTime,
    required String weekdayName,
  }) {
    int scheduleIndex = cafeSchedule
        .indexWhere((schedule) => schedule.weekDayName == weekdayName);

    if (scheduleIndex != -1) cafeSchedule[scheduleIndex].startTime = stringTime;
  }
}
