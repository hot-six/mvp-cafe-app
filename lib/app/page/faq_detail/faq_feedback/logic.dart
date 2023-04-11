import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nado_client_mvp/app/data/model/userfaq.dart';
import 'package:nado_client_mvp/app/data/provider/extensions/base.dart';
import 'package:nado_client_mvp/app/data/provider/extensions/faq_provider.dart';
import 'package:nado_client_mvp/app/global_widgets/snackbar.dart';

const String INIT_TEXT_OF_GOOD_EXPERIENCE =
    '어떤 점이 좋았나요?\n사용하면서 좋았던 부분을 작성해 주세요:)\nex.\n카페 유형 구분이 되어 있어서 좋아요!\n카페 정보가 자세히 제공되어서 좋아요!\n원하는 카페를 저장할 수 있어서 좋아요';
const String INIT_TEXT_OF_BAD_EXPERIENCE =
    '어떤 점이 불편했나요?\n사용하면서 불편했던 부분을 작성해 주세요:)\nex.\n원하는 카페 유형이 없어요.\n앱 로딩 속도가 느려요.\n카페 리뷰를 볼 수 없어서 불편해요.';
const String INIT_TEXT_OF_NEED_EXPERIENCE =
    '어떤 것이 더 필요하신가요?\n사용하면서 서비스에 필요한 것이 있으면\n작성해 주세요:)\nex.\n카페로 전화걸 수 있는 기능이 있었으면 좋겠어요.\n카페 인스타그램 아이디가 있었으면 좋겠어요.\n더 많은 지역에 서비스가 제공되었으면 좋겠어요.\n카페 리뷰를 볼 수 있었으면 좋겠어요.';

enum DropBoxText {
  GOOD('이런 점은 좋아요.'),
  BAD('이런 점은 불편해요.'),
  NEED('이런 점은 필요해요.');

  final String displayText;

  const DropBoxText(this.displayText);
}

class FAQFeedBackPageLogic extends GetxController {
  final List<DropBoxText> selectableUserExperience = [
    DropBoxText.GOOD,
    DropBoxText.BAD,
    DropBoxText.NEED,
  ];
  final Rx<DropBoxText> selectedUserExperienceText = DropBoxText.GOOD.obs;
  final RxInt userTextLength = 0.obs;
  final FocusNode userTextInputFocusNode = FocusNode();
  final UserFAQ userFAQ = UserFAQ.empty();

  late TextEditingController experienceTextController;

  @override
  void onInit() {
    super.onInit();
    experienceTextController = TextEditingController();
    userFAQ.faqDivision = FAQDivisionType.FEEDBACK;
    userFAQ.title = selectedUserExperienceText.value.displayText;
  }

  String settingHintText() {
    switch (selectedUserExperienceText.value) {
      case DropBoxText.GOOD:
        return INIT_TEXT_OF_GOOD_EXPERIENCE;
      case DropBoxText.BAD:
        return INIT_TEXT_OF_BAD_EXPERIENCE;
      case DropBoxText.NEED:
        return INIT_TEXT_OF_NEED_EXPERIENCE;
    }
  }

  void changeDropBoxValue({
    required DropBoxText? changedValue,
  }) {
    if (changedValue != null) {
      selectedUserExperienceText.value = changedValue;
      userFAQ.title = selectedUserExperienceText.value.displayText;
    }
  }

  Future<void> onSubmitFAQ() async {
    final NadoProvider provider = Get.find<NadoProvider>();

    userFAQ.content = experienceTextController.text;
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
