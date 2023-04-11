import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nado_client_mvp/app/data/model/cafe.dart';
import 'package:nado_client_mvp/app/data/model/type.dart';
import 'package:nado_client_mvp/app/page/search/view.dart';

class EnrollCafeTypesLogic extends GetxController {
  final CafeDetail ceoCafeDetailData;
  final CafeTile ceoCafeTileData;
  late RxMap<CafeCategoryType, List<CafeType>> selectedCafeTypes =
      <CafeCategoryType, List<CafeType>>{}.obs;

  final RxBool isLoaded = false.obs;

  EnrollCafeTypesLogic({
    required this.ceoCafeDetailData,
    required this.ceoCafeTileData,
  });

  @override
  void onInit() {
    super.onInit();

    isLoaded.value = false;

    Map<CafeCategoryType, List<CafeType>> selectedCafeTypeMap = {};

    ceoCafeDetailData.cafeTypes.forEach((cafeType) {
      if (selectedCafeTypeMap.keys.contains(cafeType.category))
        selectedCafeTypeMap[cafeType.category]!.add(cafeType);
      else
        selectedCafeTypeMap[cafeType.category] = [cafeType];
    });

    selectedCafeTypes.value = selectedCafeTypeMap;

    isLoaded.value = true;
  }

  void getUserSelectedCafeType() async {
    isLoaded.value = false;
    await Get.to<Map<CafeCategoryType, List<CafeType>>>(
        () => ClientSearchPage(),
        arguments: {
          'selectedTypes': selectedCafeTypes,
          'wantMapType': true,
        });

    isLoaded.value = true;
  }

  void saveDataAndNextStep(PageController pageController) async {
    List<CafeType> cafeTypeList = [];

    selectedCafeTypes.values.forEach((typeList) {
      cafeTypeList.addAll(typeList);
    });

    ceoCafeDetailData.cafeTypes = cafeTypeList;
    ceoCafeTileData.cafeTypes = cafeTypeList.sublist(
      0,
      cafeTypeList.length < 3 ? cafeTypeList.length : 3,
    );

    pageController.animateToPage(
      3,
      duration: Duration(microseconds: 500),
      curve: Curves.linear,
    );
  }
}
