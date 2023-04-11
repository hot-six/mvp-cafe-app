import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nado_client_mvp/app/data/model/cafe.dart';
import 'package:nado_client_mvp/app/data/model/menu.dart';
import 'package:nado_client_mvp/app/data/model/schedule.dart';
import 'package:nado_client_mvp/app/global_widgets/snackbar.dart';
import 'package:nado_client_mvp/app/routes/routes.dart';

class EnrollCafeFormLogic extends GetxController {
  final CafeDetail ceoCafeDetailData;
  final CafeTile ceoCafeTileData;
  final Function onSubmit;
  // controller
  late TextEditingController cafeNameController;
  late TextEditingController cafeIntroduceController;

  late TextEditingController cafeNumberFirstController;
  late TextEditingController cafeNumberSecondController;
  late TextEditingController cafeNumberThirdController;

  final FocusNode cafeNameFocusNode = FocusNode();
  final FocusNode cafeIntroduceFocusNode = FocusNode();
  final FocusNode pageFocusNode = FocusNode();

  RxBool isCafeOpenTimeEqual = true.obs;

  final RxList<Menu> cafeMenuList =
      [Menu(name: '', price: 0, description: 'abc')].obs;

  final RxList<CafeSchedule> cafeDifferentSchedule = <CafeSchedule>[].obs;
  final Rx<CafeSchedule> cafeSameSchedule = CafeSchedule.empty().obs;

  EnrollCafeFormLogic({
    required this.ceoCafeDetailData,
    required this.ceoCafeTileData,
    required this.onSubmit,
  });

  @override
  void onInit() {
    super.onInit();

    // inti menu
    if (ceoCafeDetailData.menus.isEmpty) {
      cafeMenuList.value = [Menu(name: '', price: 0, description: '')];
    } else {
      cafeMenuList.value = [
        ...ceoCafeDetailData.menus,
        Menu(name: '', price: 0, description: '')
      ];
    }

    // init Schedule
    cafeDifferentSchedule.value = ceoCafeDetailData.schedules;

    cafeNameController =
        TextEditingController(text: ceoCafeDetailData.cafeName);
    cafeIntroduceController =
        TextEditingController(text: ceoCafeDetailData.cafeDescription);

    List<String> splitedCafeNumber = ceoCafeDetailData.cafeNumber.split('-');

    if (splitedCafeNumber.length == 3) {
      cafeNumberFirstController =
          TextEditingController(text: splitedCafeNumber[0]);
      cafeNumberSecondController =
          TextEditingController(text: splitedCafeNumber[1]);
      cafeNumberThirdController =
          TextEditingController(text: splitedCafeNumber[2]);
    } else {
      cafeNumberFirstController = TextEditingController();
      cafeNumberSecondController = TextEditingController();
      cafeNumberThirdController = TextEditingController();
    }
  }

  @override
  void dispose() {
    cafeNameController.dispose();
    super.dispose();
  }

  void saveDataAndNextStep() async {
    ceoCafeDetailData.cafeName = cafeNameController.text;
    ceoCafeDetailData.cafeDescription = cafeIntroduceController.text;
    ceoCafeDetailData.cafeNumber =
        '${cafeNumberFirstController.text}-${cafeNumberSecondController.text}-${cafeNumberThirdController.text}';
    // ceoCafe schedule은 처리됐음. 다른 것들 도 cafe schedule 처럼 인자로 전달해서 변경할 수 있게 수정해보자

    ceoCafeDetailData.menus =
        cafeMenuList.where((menu) => menu.name.isNotEmpty == true).toList();

    ceoCafeDetailData.mainSchedule = ceoCafeDetailData.schedules[0];

    ceoCafeTileData.mainSchedule = ceoCafeDetailData.schedules[0];
    ceoCafeTileData.cafeName = ceoCafeDetailData.cafeName;

    await onSubmit();

    Get.offAllNamed(Routes.CEO_PAGE);

    NoticeSnackBar.defaultSnackBar(content: '카페 정보가 수정되었습니다.');
  }
}
