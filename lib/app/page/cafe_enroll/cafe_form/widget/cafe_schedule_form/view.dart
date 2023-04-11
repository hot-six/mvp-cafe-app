import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nado_client_mvp/app/data/model/schedule.dart';
import 'package:nado_client_mvp/app/page/cafe_enroll/cafe_form/widget/cafe_schedule_form/logic.dart';
import 'package:nado_client_mvp/app/page/cafe_enroll/cafe_form/widget/cafe_schedule_form/widget/cafe_different_schedule/view.dart';
import 'package:nado_client_mvp/app/page/cafe_enroll/cafe_form/widget/cafe_schedule_form/widget/cafe_same_schedule/view.dart';

class CafeScheduleForm extends StatelessWidget {
  final List<CafeSchedule> cafeSchedule;
  final CafeScheduleFormLogic logic;

  CafeScheduleForm({required this.cafeSchedule})
      : logic = Get.put(CafeScheduleFormLogic(cafeSchedule: cafeSchedule));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '영업 요일과 시간을 입력해 주세요',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12.0),
          SameCafeSchedule(
            cafeSchedule: logic.cafeSchedule,
            isSettingWithEqualTime: logic.isCafeOpenTimeEqual,
          ),
          SizedBox(height: 12.0),
          DifferentCafeSchedule(
            cafeSchedule: logic.cafeSchedule,
            isSettingWithEqualTime: logic.isCafeOpenTimeEqual,
          ),
        ],
      ),
    );
  }
}
