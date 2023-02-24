import 'package:get/get.dart';

class ClientSearchPageLogic extends GetxController {
  late final Map<String, List<String>> cafeTypeData;
  final RxList<String> selectedCafeTypeList = <String>[].obs;

  @override
  void onInit() {
    super.onInit();

    List<String> alreadySelectedType = Get.arguments ?? [];

    selectedCafeTypeList.value = alreadySelectedType;
    // Provider를 통해 api call 필요
    cafeTypeData = {
      '맛집': [
        '에스프레소 맛집',
        '뷰 맛집',
        '디카페인 맛집',
        '시그니처 맛집',
        '베이글 맛집',
        '케이크 맛집',
        '샐러드 맛집',
      ],
      '공간': [
        '한옥',
        '루프탑',
        '창고형',
        '애견동반',
      ],
      '시설': [
        '야외석',
        '노키즈존',
        '유아동반가능',
      ],
      '분위기': [
        '모임하기 좋은',
        '휴식하기 좋은',
        '풍경이 좋은',
        '공부하기 좋은',
        '사진찍기 좋은',
        '독서하기 좋은',
      ],
      '분위기2': [
        '모임하기 좋은',
        '휴식하기 좋은',
        '풍경이 좋은',
        '공부하기 좋은',
        '사진찍기 좋은',
        '독서하기 좋은',
      ],
      '분위기3': [
        '모임하기 좋은',
        '휴식하기 좋은',
        '풍경이 좋은',
        '공부하기 좋은',
        '사진찍기 좋은',
        '독서하기 좋은',
      ],
    };
  }

  void onTapCafeTypeUnit({required String cafeType}) {
    if (!selectedCafeTypeList.contains(cafeType))
      selectedCafeTypeList.add(cafeType);
    else
      selectedCafeTypeList.remove(cafeType);

    print(selectedCafeTypeList);
  }

  void onTapResetSelectedCafeType() {
    selectedCafeTypeList.value = [];
  }

  void onTapSubmitSelectedCafeType() {
    print('back');
    Get.back(result: selectedCafeTypeList);
  }
}
