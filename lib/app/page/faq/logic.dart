import 'package:flutter/material.dart';
import 'package:get/get.dart';

const String INIT_TEXT_OF_GOOD_EXPERIENCE =
    '어떤 점이 좋았나요?\n사용하면서 좋았던 부분을 작성해 주세요:)\nex.\n카페 유형 구분이 되어 있어서 좋아요!\n카페 정보가 자세히 제공되어서 좋아요!\n원하는 카페를 저장할 수 있어서 좋아요';
const String INIT_TEXT_OF_BAD_EXPERIENCE =
    '어떤 점이 불편했나요?\n사용하면서 불편했던 부분을 작성해 주세요:)\nex.\n원하는 카페 유형이 없어요.\n앱 로딩 속도가 느려요.\n카페 리뷰를 볼 수 없어서 불편해요.';
const String INIT_TEXT_OF_NEED_EXPERIENCE =
    '어떤 것이 더 필요하신가요?\n사용하면서 서비스에 필요한 것이 있으면\n작성해 주세요:)\nex.\n원하는 카페 유형이 없어요.\n앱 로딩 속도가 느려요.\n카페 리뷰를 볼 수 없어서 불편해요.';
const String INIT_TEXT_OF_REQUIRED_AREA =
    '서비스를 희망하는 구체적인 지역이 있을 경우 자유롭게 작성해 주세요.\nex.\n잠실, 성수, 홍대, 부산, 제주 등';

enum DropBoxText {
  GOOD('이런 점은 좋아요.'),
  BAD('이런 점은 불편해요.'),
  NEED('이런 점은 필요해요.');

  final String displayText;

  const DropBoxText(this.displayText);
}

class FAQPageLogic extends GetxController {
  final List<DropBoxText> selectableUserExperience = [
    DropBoxText.GOOD,
    DropBoxText.BAD,
    DropBoxText.NEED,
  ];
  final Rx<DropBoxText> selectedUserExperienceText = DropBoxText.GOOD.obs;

  late TextEditingController experienceTextController;
  late TextEditingController requiredRegionTextController;

  @override
  void onInit() {
    super.onInit();
    experienceTextController = TextEditingController();
    requiredRegionTextController = TextEditingController();
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
}
