import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nado_client_mvp/app/data/model/menu.dart';
import 'package:nado_client_mvp/app/global_widgets/snackbar.dart';
import 'package:nado_client_mvp/app/page/cafe_enroll/cafe_form/widget/cafe_menu_form/logic.dart';

class CafeMenuFormRowLogic extends GetxController {
  final Menu cafeMenu;

  late TextEditingController menuNameController;
  late TextEditingController menuPriceController;

  late RxBool isSignature = false.obs;

  CafeMenuFormRowLogic({required this.cafeMenu});

  @override
  void onInit() {
    super.onInit();
    menuNameController = TextEditingController(text: cafeMenu.name);
    menuPriceController =
        TextEditingController(text: cafeMenu.price.toString());

    isSignature.value = cafeMenu.isSignature ?? false;
  }

  void onDeleteCafeMenu(index) {
    CafeMenuFormLogic formLogic = Get.find<CafeMenuFormLogic>();

    if (formLogic.cafeMenuList.length > 1) {
      formLogic.cafeMenuList.removeAt(index);

      formLogic.cafeMenuList.refresh();
    } else {
      NoticeSnackBar.defaultSnackBar(content: '최소 1개의 메뉴를 등록해야 합니다.');
    }
  }

  void onTapSignatureSign() {
    isSignature.value = !isSignature.value;
    cafeMenu.isSignature = isSignature.value;
  }
}
