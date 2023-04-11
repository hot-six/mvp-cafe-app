import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nado_client_mvp/app/data/model/userfaq.dart';
import 'package:nado_client_mvp/app/data/provider/extensions/base.dart';
import 'package:nado_client_mvp/app/data/provider/extensions/faq_provider.dart';
import 'package:nado_client_mvp/app/global_widgets/snackbar.dart';

const String INIT_TEXT_OF_REQUIRED_AREA =
    '서비스를 희망하는 구체적인 지역이 있을 경우\n자유롭게 작성해 주세요.\n\nex.\n잠실, 성수, 홍대, 부산, 제주 등';

class FAQRegionPageLogic extends GetxController {
  final List<String> regionList = [
    '서울',
    '경기',
    '인천',
    '강원',
    '충북',
    '충남',
    '경북',
    '경남',
    '전북',
    '전남',
    '제주',
  ];
  final RxString selectedUserExperienceText = '서울'.obs;
  final RxInt userTextLength = 0.obs;
  final FocusNode userTextInputFocusNode = FocusNode();
  final UserFAQ userFAQ = UserFAQ.empty();

  late TextEditingController requiredRegionTextController;

  @override
  void onInit() {
    super.onInit();
    requiredRegionTextController = TextEditingController();
    userFAQ.faqDivision = FAQDivisionType.REGION;
    userFAQ.title = selectedUserExperienceText.value;
  }

  void changeDropBoxValue({
    required String? changedValue,
  }) {
    if (changedValue != null) {
      selectedUserExperienceText.value = changedValue;
      userFAQ.title = selectedUserExperienceText.value;
    }
  }

  Future<void> onSubmitFAQ() async {
    final NadoProvider provider = Get.find<NadoProvider>();

    userFAQ.content = requiredRegionTextController.text;
    try {
      await provider.postUserFAQ(userFeedBack: userFAQ).then((value) {
        Get.back();
        NoticeSnackBar.defaultSnackBar(content: '제출이 완료되었습니다.');
      });
    } on Exception catch (error) {
      printInfo(info: 'Failed FAQ Submit.');
    }
  }
}
