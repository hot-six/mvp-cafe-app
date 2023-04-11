import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nado_client_mvp/app/core/values/colors.dart';
import 'package:nado_client_mvp/app/data/model/schedule.dart';
import 'package:nado_client_mvp/app/page/cafe_enroll/cafe_form/widget/cafe_schedule_form/widget/cafe_different_schedule/logic.dart';
import 'package:nado_client_mvp/app/page/cafe_enroll/cafe_form/widget/cafe_schedule_form/widget/cafe_schedule_form_row/view.dart';

class DifferentCafeSchedule extends StatelessWidget {
  final List<CafeSchedule> cafeSchedule;
  final RxBool isSettingWithEqualTime;
  final DifferentCafeScheduleLogic logic;

  DifferentCafeSchedule(
      {required this.cafeSchedule, required this.isSettingWithEqualTime})
      : logic = Get.put(DifferentCafeScheduleLogic(cafeSchedule: cafeSchedule));

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          InkWell(
            onTap: () {
              isSettingWithEqualTime.value = false;
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSettingWithEqualTime.value
                      ? NadoColor.greyColor
                      : NadoColor.primary,
                ),
                borderRadius: BorderRadius.circular(100.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isSettingWithEqualTime.value == false
                      ? Image.asset(
                          'assets/images/check_filled_primary.png',
                        )
                      : Image.asset(
                          'assets/images/check_filled.png',
                        ),
                  SizedBox(width: 9.0),
                  Text(
                    '영업 시간이 요일별 달라요.',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: isSettingWithEqualTime.value
                          ? NadoColor.greyColor
                          : NadoColor.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12.0),
          isSettingWithEqualTime.value == false
              ? Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                  color: NadoColor.greyColor[100],
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          logic.cafeSchedule.length,
                          (index) {
                            CafeSchedule scheduleData =
                                logic.cafeSchedule[index];
                            return Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    logic.onChangeIsOpen(
                                      weekdayName: scheduleData.weekDayName,
                                    );
                                  },
                                  child: Obx(
                                    () => Container(
                                      width: 34.0,
                                      height: 34.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: logic
                                                .cafeScheduleToggleList[index]
                                                .value
                                            ? NadoColor.primary
                                            : NadoColor.greyColor[300]!,
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        scheduleData.weekDayName,
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5.0),
                              ],
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Column(
                        children:
                            List.generate(logic.cafeSchedule.length, (index) {
                          CafeSchedule scheduleData = logic.cafeSchedule[index];
                          return Column(
                            children: [
                              SizedBox(height: 12.0),
                              CafeScheduleFormRow(
                                isOpen:
                                    logic.cafeScheduleToggleList[index].value,
                                weekDayName: scheduleData.weekDayName,
                                onChangeStartTime: (String stringTime) {
                                  logic.onChangeStartTime(
                                    stringTime: stringTime,
                                    weekdayName: scheduleData.weekDayName,
                                  );
                                },
                                onChangeEndTime: (String stringTime) {
                                  logic.onChangeEndTime(
                                    stringTime: stringTime,
                                    weekdayName: scheduleData.weekDayName,
                                  );
                                },
                                startTimeController:
                                    logic.startTimeControllerList[index],
                                endTimeController:
                                    logic.endTimeControllerList[index],
                              ),
                            ],
                          );
                        }),
                      ),
                    ],
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
