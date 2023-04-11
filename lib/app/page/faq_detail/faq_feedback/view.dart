import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nado_client_mvp/app/core/values/colors.dart';
import 'package:nado_client_mvp/app/global_widgets/dismiss_keyboard.dart';
import 'package:nado_client_mvp/app/page/faq_detail/faq_feedback/logic.dart';

class FAQFeedBackPage extends StatelessWidget {
  final FAQFeedBackPageLogic logic = Get.put(FAQFeedBackPageLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('피드백 제공'),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '유형을 선택해 주세요.',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.0),
                _experienceDropBox(context),
                SizedBox(height: 15.0),
                _experienceTextBox(),
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
              padding: EdgeInsets.symmetric(vertical: 21.0),
              width: double.infinity,
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
            padding: EdgeInsets.only(left: 10.0, right: 14.0),
          ),
          dropdownStyleData: DropdownStyleData(
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
            logic.selectableUserExperience.length,
            (index) => DropdownMenuItem(
              value: logic.selectableUserExperience[index],
              child: Text(logic.selectableUserExperience[index].displayText),
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
        controller: logic.experienceTextController,
        minLines: 10,
        maxLines: null,
        maxLength: 500,
        onChanged: (value) {
          logic.userTextLength.value =
              logic.experienceTextController.text.length;
        },
        decoration: InputDecoration(
          hintText: logic.settingHintText(),
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
