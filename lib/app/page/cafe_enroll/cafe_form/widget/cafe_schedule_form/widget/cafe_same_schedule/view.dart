import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nado_client_mvp/app/core/values/colors.dart';
import 'package:nado_client_mvp/app/data/model/schedule.dart';
import 'package:nado_client_mvp/app/page/cafe_enroll/cafe_form/widget/cafe_schedule_form/widget/cafe_same_schedule/logic.dart';
import 'package:nado_client_mvp/app/page/cafe_enroll/cafe_form/widget/cafe_schedule_form/widget/cafe_schedule_form_row/view.dart';

class SameCafeSchedule extends StatelessWidget {
  final List<CafeSchedule> cafeSchedule;
  final RxBool isSettingWithEqualTime;
  final SameCafeScheduleLogic logic;

  SameCafeSchedule(
      {required this.cafeSchedule, required this.isSettingWithEqualTime})
      : logic = Get.put(SameCafeScheduleLogic(cafeSchedule: cafeSchedule));

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          InkWell(
            onTap: () {
              isSettingWithEqualTime.value = true;
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 14.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSettingWithEqualTime.value
                      ? NadoColor.primary
                      : NadoColor.greyColor,
                ),
                borderRadius: BorderRadius.circular(100.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isSettingWithEqualTime.value
                      ? Image.asset(
                          'assets/images/check_filled_primary.png',
                        )
                      : Image.asset(
                          'assets/images/check_filled.png',
                        ),
                  SizedBox(width: 9.0),
                  Text(
                    '영업 시간이 매일 동일해요.',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: isSettingWithEqualTime.value
                          ? NadoColor.primary
                          : NadoColor.greyColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          isSettingWithEqualTime.value
              ? Column(children: [
                  SizedBox(height: 12.0),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                    decoration: BoxDecoration(
                      color: NadoColor.greyColor[100],
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: CafeScheduleFormRow(
                      weekDayName: '월 ~ 일',
                      onChangeStartTime: logic.onChangeStartTime,
                      onChangeEndTime: logic.onChangeEndTime,
                      startTimeController: logic.startTimeController,
                      endTimeController: logic.endTimeController,
                      isOpen: true,
                    ),
                  ),
                ])
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
