import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nado_client_mvp/app/core/values/colors.dart';
import 'package:nado_client_mvp/app/data/model/cafe.dart';
import 'package:nado_client_mvp/app/global_widgets/dismiss_keyboard.dart';
import 'package:nado_client_mvp/app/page/cafe_enroll/cafe_form/logic.dart';
import 'package:nado_client_mvp/app/global_widgets/input.dart';
import 'package:nado_client_mvp/app/page/cafe_enroll/cafe_form/widget/cafe_menu_form/view.dart';
import 'package:nado_client_mvp/app/page/cafe_enroll/cafe_form/widget/cafe_schedule_form/view.dart';

class EnrollCafeForm extends StatelessWidget {
  final CafeDetail ceoCafeDetailData;
  final CafeTile ceoCafeTileData;
  final Function onSubmit;

  final EnrollCafeFormLogic logic;

  EnrollCafeForm(
      {required this.ceoCafeDetailData,
      required this.ceoCafeTileData,
      required this.onSubmit})
      : logic = Get.put(EnrollCafeFormLogic(
          ceoCafeDetailData: ceoCafeDetailData,
          ceoCafeTileData: ceoCafeTileData,
          onSubmit: onSubmit,
        ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '카페 정보 입력하기',
        ),
      ),
      body: DismissKeyboard(
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _cafeNameInput(),
                    SizedBox(height: 34.0),
                    _cafeIntroduceInput(),
                    SizedBox(height: 34.0),
                    CafeScheduleForm(
                      cafeSchedule: logic.ceoCafeDetailData.schedules,
                    ),
                    SizedBox(height: 34.0),
                    _cafePhoneForm(),
                    SizedBox(height: 34.0),
                    _cafeAddressForm(),
                    SizedBox(height: 34.0),
                    CafeMenuForm(
                      cafeMenuList: logic.cafeMenuList,
                    ),
                    SizedBox(height: 34.0),
                  ],
                ),
                submitForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget formWidgetContainer({required Widget child}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: child,
    );
  }

  Widget _formTitle({required String title}) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _cafeNameInput() {
    return formWidgetContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _formTitle(title: '카페 이름을 입력해 주세요'),
          SizedBox(height: 12),
          OvalInputField(
            textEditingController: logic.cafeNameController,
            hintText: '카페명',
          )
        ],
      ),
    );
  }

  Widget _cafeIntroduceInput() {
    return formWidgetContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _formTitle(title: '카페 소개를 입력해 주세요'),
          SizedBox(height: 12.0),
          SquareMultiInputField(
            textEditingController: logic.cafeIntroduceController,
          ),
        ],
      ),
    );
  }

  Widget _cafePhoneForm() {
    return formWidgetContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _formTitle(title: '매장 번호를 입력해 주세요'),
          SizedBox(height: 12.0),
          Row(
            children: [
              // TODO : 드롭박스
              Expanded(
                child: SquareInputField(
                  keyboardType: TextInputType.number,
                  textEditingController: logic.cafeNumberFirstController,
                  hintText: '010',
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.0),
                child: Text('-'),
              ),
              Expanded(
                child: SquareInputField(
                  keyboardType: TextInputType.number,
                  textEditingController: logic.cafeNumberSecondController,
                  hintText: '0000',
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.0),
                child: Text('-'),
              ),
              Expanded(
                child: SquareInputField(
                  keyboardType: TextInputType.number,
                  textEditingController: logic.cafeNumberThirdController,
                  hintText: '0000',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _cafeAddressForm() {
    return formWidgetContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _formTitle(title: '매장 주소를 입력해 주세요'),
          SizedBox(height: 12.0),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: NadoColor.greyColor[400],
              borderRadius: BorderRadius.circular(100.0),
            ),
            padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 14.0),
            child: Text(
              '베타 서비스로 수정 불가합니다.',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget submitForm() {
    return InkWell(
      onTap: () {
        logic.saveDataAndNextStep();
      },
      child: Container(
        width: double.infinity,
        height: 60.0,
        color: NadoColor.greyColor[500],
        alignment: Alignment.center,
        child: Text(
          '저장',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
