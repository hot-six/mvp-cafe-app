import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nado_client_mvp/app/core/values/colors.dart';
import 'package:nado_client_mvp/app/global_widgets/dismiss_keyboard.dart';
import 'package:nado_client_mvp/app/page/faq_detail/faq_region/logic.dart';

class FAQRegionPage extends StatelessWidget {
  final FAQRegionPageLogic logic = Get.put(FAQRegionPageLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('서비스 추가 희망 지역'),
      ),
      body: DismissKeyboard(
        child: _useExperience(context),
      ),
    );
  }

  Widget _useExperience(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            color: NadoColor.greyColor[100],
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '서비스 추가 희망 지역을 작성해 주세요.',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.0),
                _experienceDropBox(context),
                SizedBox(height: 15.0),
                _experienceTextBox(),
                Spacer(),
              ],
            ),
          ),
        ),
        Obx(
          () => InkWell(
            onTap: () async {
              if (logic.userTextLength.value > 0) await logic.onSubmitFAQ();
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 21.0),
              color: logic.userTextLength.value > 0
                  ? NadoColor.greyColor[500]
                  : NadoColor.greyColor,
              child: Text(
                '제출하기',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _experienceDropBox(BuildContext context) {
    return Obx(
      () => DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: NadoColor.greyColor), //border of dropdown button
          borderRadius: BorderRadius.circular(50),
        ),
        child: DropdownButton2(
          buttonStyleData: ButtonStyleData(
            padding: EdgeInsets.only(right: 14.0),
          ),
          dropdownStyleData: DropdownStyleData(
            padding: EdgeInsets.only(left: 10.0),
            offset: Offset(0, -10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: NadoColor.greyColor[200]!,
              ),
              borderRadius: BorderRadius.circular(13.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.white,
                )
              ],
            ),
          ),
          menuItemStyleData: MenuItemStyleData(
            padding: EdgeInsets.only(left: 10.0, right: 14.0),
          ),
          items: List.generate(
            logic.regionList.length,
            (index) => DropdownMenuItem(
              value: logic.regionList[index],
              child: Text(logic.regionList[index]),
            ),
          ).toList(),
          onChanged: (value) {
            logic.changeDropBoxValue(changedValue: value);
          },
          value: logic.selectedUserExperienceText.value,
          underline: SizedBox(),
          isExpanded: true,
        ),
      ),
    );
  }

  Widget _experienceTextBox() {
    return Obx(
      () => TextField(
        focusNode: logic.userTextInputFocusNode,
        controller: logic.requiredRegionTextController,
        minLines: 10,
        maxLines: null,
        maxLength: 500,
        onChanged: (value) {
          logic.userTextLength.value =
              logic.requiredRegionTextController.text.length;
        },
        decoration: InputDecoration(
          hintText: INIT_TEXT_OF_REQUIRED_AREA,
          hintMaxLines: 10,
          hintStyle: TextStyle(fontSize: 16.0, color: NadoColor.greyColor),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: NadoColor.greyColor[200]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: NadoColor.primary),
          ),
          counterText: '${logic.userTextLength} / 500',
        ),
      ),
    );
  }
}
