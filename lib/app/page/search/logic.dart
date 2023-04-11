import 'package:get/get.dart';
import 'package:nado_client_mvp/app/core/values/type.dart';
import 'package:nado_client_mvp/app/data/model/type.dart';

class ClientSearchPageLogic extends GetxController {
  late final Map<CafeCategoryType, List<CafeType>> cafeTypeData;
  RxMap<CafeCategoryType, List<CafeType>> selectedCafeTypeMap =
      <CafeCategoryType, List<CafeType>>{}.obs;
  final RxList<CafeType> selectedCafeTypeList = <CafeType>[].obs;
  late bool wantMapType;

  final RxBool isLoaded = false.obs;

  @override
  void onInit() {
    super.onInit();

    isLoaded.value = false;

    cafeTypeData = cafeTypePrividedData;

    wantMapType = Get.arguments['wantMapType'] ?? false;

    if (Get.arguments['selectedTypes'] != null &&
        Get.arguments['selectedTypes'] is List) {
      selectedCafeTypeList.value = Get.arguments['selectedTypes'];
    } else {
      selectedCafeTypeMap = Get.arguments['selectedTypes'];

      List<CafeType> originalCafeTypeList = [];

      cafeTypeData.values.forEach((element) {
        originalCafeTypeList.addAll(element);
      });

      selectedCafeTypeMap.values.forEach(
        (selectedTypeList) {
          selectedTypeList.forEach((cafeType) {
            List<CafeType> filteredList = originalCafeTypeList
                .where(
                  (type) =>
                      (type.category == cafeType.category) &&
                      (type.type == cafeType.type) &&
                      (type.typeName == cafeType.typeName),
                )
                .toList();

            selectedCafeTypeList.addAll(filteredList);
          });
        },
      );
    }

    isLoaded.value = true;
  }

  void onTapCafeTypeUnit({
    required CafeCategoryType cafeCategory,
    required CafeType cafeType,
  }) {
    if (selectedCafeTypeList.contains(cafeType)) {
      selectedCafeTypeList.remove(cafeType);
      if (selectedCafeTypeMap[cafeCategory] != null &&
          selectedCafeTypeMap[cafeCategory]!.isNotEmpty)
        selectedCafeTypeMap.remove(cafeCategory);
    } else {
      selectedCafeTypeList.add(cafeType);
      if (selectedCafeTypeMap[cafeCategory] != null)
        selectedCafeTypeMap[cafeCategory]!.add(cafeType);
      else
        selectedCafeTypeMap[cafeCategory] = [cafeType];
    }
  }

  void onTapResetSelectedCafeType() {
    selectedCafeTypeList.clear();
    selectedCafeTypeMap.clear();
  }

  void onTapSubmitSelectedCafeType() {
    Get.back(result: wantMapType ? selectedCafeTypeMap : selectedCafeTypeList);
  }
}
