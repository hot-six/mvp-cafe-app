import 'package:nado_client_mvp/app/data/model/type.dart';

Map<CafeCategoryType, List<CafeType>> cafeTypePrividedData = {
  CafeCategoryType.CAFE: [
    CafeType(
      category: CafeCategoryType.CAFE,
      type: 'COFFEE',
      typeName: '커피 맛집',
    ),
    CafeType(
      category: CafeCategoryType.CAFE,
      type: 'SIGNATURE',
      typeName: '시그니처 음료',
    ),
    CafeType(
      category: CafeCategoryType.CAFE,
      type: 'VIEW',
      typeName: '뷰 맛집',
    ),
    CafeType(
      category: CafeCategoryType.CAFE,
      type: 'DESSERT',
      typeName: '디저트 맛집',
    ),
    CafeType(
      category: CafeCategoryType.CAFE,
      type: 'BAKERY',
      typeName: '베이커리 맛집',
    ),
    CafeType(
      category: CafeCategoryType.CAFE,
      type: 'BRUNCH',
      typeName: '브런치 맛집',
    ),
  ],
  CafeCategoryType.SPACE: [
    CafeType(
      category: CafeCategoryType.SPACE,
      type: 'HANOK',
      typeName: '한옥',
    ),
    CafeType(
      category: CafeCategoryType.SPACE,
      type: 'ROOFTOP',
      typeName: '루프탑',
    ),
    CafeType(
      category: CafeCategoryType.SPACE,
      type: 'WAREHOUSE',
      typeName: '창고형',
    ),
    CafeType(
      category: CafeCategoryType.SPACE,
      type: 'PET',
      typeName: '애견 동반',
    ),
    CafeType(
      category: CafeCategoryType.SPACE,
      type: 'PLANT',
      typeName: '식물',
    ),
  ],
  CafeCategoryType.FACILITY: [
    CafeType(
      category: CafeCategoryType.FACILITY,
      type: 'OUTDOOR',
      typeName: '야외석',
    ),
    CafeType(
      category: CafeCategoryType.FACILITY,
      type: 'PARKING',
      typeName: '주차',
    ),
    CafeType(
      category: CafeCategoryType.FACILITY,
      type: 'NOKIDS',
      typeName: '노키즈존',
    ),
  ],
  CafeCategoryType.MOOD: [
    CafeType(
      category: CafeCategoryType.MOOD,
      type: 'STUDY',
      typeName: '공부하기 좋은',
    ),
    CafeType(
      category: CafeCategoryType.MOOD,
      type: 'PICTURE',
      typeName: '사진찍기 좋은',
    ),
    CafeType(
      category: CafeCategoryType.MOOD,
      type: 'MEET',
      typeName: '모임하기 좋은',
    ),
  ],
};
