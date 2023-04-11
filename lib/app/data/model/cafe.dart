import 'package:json_annotation/json_annotation.dart';
import 'package:nado_client_mvp/app/data/model/image.dart';
import 'package:nado_client_mvp/app/data/model/menu.dart';
import 'package:nado_client_mvp/app/data/model/schedule.dart';
import 'package:nado_client_mvp/app/data/model/type.dart';

part 'cafe.g.dart';

enum CafeOpenType {
  BEFORE_OPEN("영업 전"),
  OPEN("영업 중"),
  CLOSED("영업 종료"),
  BREAK_TIME("브레이크 타임"),
  NA("");

  final String displayName;

  const CafeOpenType(this.displayName);
}

@JsonSerializable()
class Cafe {
  @JsonKey(name: "cafeId")
  int id;
  @JsonKey(name: "name")
  String cafeName;
  @JsonKey(name: "address")
  String cafeAddress;
  @JsonKey(name: "latitude")
  double latitude;
  @JsonKey(name: "longitude")
  double longitude;
  @JsonKey(name: "mainSchedule")
  CafeSchedule mainSchedule;
  @JsonKey(name: 'openType')
  CafeOpenType openType;
  @JsonKey(name: "types")
  List<CafeType> cafeTypes;
  @JsonKey(name: "is_favorite")
  bool? isFavorite;

  Cafe({
    required this.id,
    required this.cafeName,
    required this.cafeAddress,
    required this.mainSchedule,
    required this.latitude,
    required this.longitude,
    required this.cafeTypes,
    required this.openType,
    this.isFavorite,
  });

  Cafe.empty()
      : id = 0,
        cafeName = '',
        cafeAddress = '',
        mainSchedule = CafeSchedule.empty(),
        latitude = 0.0,
        longitude = 0.0,
        cafeTypes = [],
        openType = CafeOpenType.NA,
        isFavorite = false;

  Cafe.full()
      : id = 99999,
        cafeName = '나동글 카페',
        cafeAddress = '경기도 남양주시 나동글 카페',
        mainSchedule = CafeSchedule.full(weekDayName: '월'),
        latitude = 37.6059661,
        longitude = 127.2799223,
        // latitude = 37.583651,
        // longitude = 127.2256773,
        cafeTypes = [
          CafeType.full(
            category: CafeCategoryType.SPACE,
            type: 'WAREHOUSE',
            typeName: '창고형',
          ),
          CafeType.full(
            category: CafeCategoryType.SPACE,
            type: 'ROOFTOP',
            typeName: '루프탑',
          ),
          CafeType.full(
            category: CafeCategoryType.MOOD,
            type: 'MEET',
            typeName: '모임하기 좋은',
          ),
          CafeType.full(
            category: CafeCategoryType.CAFE,
            type: 'VIEW',
            typeName: '뷰 맛집',
          ),
          CafeType.full(
            category: CafeCategoryType.MOOD,
            type: 'PICTURE',
            typeName: '사진찍기 좋은',
          ),
          CafeType.full(
            category: CafeCategoryType.SPACE,
            type: 'PLANT',
            typeName: '식물',
          ),
        ],
        openType = CafeOpenType.BEFORE_OPEN,
        isFavorite = false;

  factory Cafe.fromJson(Map<String, dynamic> json) => _$CafeFromJson(json);
  Map<String, dynamic> toJson() => _$CafeToJson(this);
}

@JsonSerializable()
class CafeTile extends Cafe {
  @JsonKey(name: "accuracy")
  double accuracy;
  @JsonKey(name: "thumbnail")
  CafeImage? thumbnail;

  CafeTile({
    required super.id,
    required super.cafeName,
    required super.cafeAddress,
    required super.mainSchedule,
    required super.latitude,
    required super.longitude,
    required super.cafeTypes,
    required super.openType,
    required this.accuracy,
    super.isFavorite,
    this.thumbnail,
  });

  CafeTile.empty()
      : accuracy = 0.0,
        thumbnail = null,
        super.full();

  CafeTile.full()
      : accuracy = 100.0,
        thumbnail = null,
        super.full();

  factory CafeTile.fromJson(Map<String, dynamic> json) =>
      _$CafeTileFromJson(json);
  Map<String, dynamic> toJson() => _$CafeTileToJson(this);
}

@JsonSerializable()
class CafeDetail extends Cafe {
  @JsonKey(name: "description")
  String? cafeDescription;
  @JsonKey(name: "number")
  String cafeNumber;
  @JsonKey(name: "menus")
  List<Menu> menus;
  @JsonKey(name: "schedules")
  List<CafeSchedule> schedules;
  @JsonKey(name: "images")
  List<CafeImage> images;

  CafeDetail({
    required super.id,
    required super.cafeName,
    required super.cafeAddress,
    required super.mainSchedule,
    required super.latitude,
    required super.longitude,
    required super.cafeTypes,
    required super.openType,
    required this.cafeDescription,
    required this.cafeNumber,
    required this.menus,
    required this.schedules,
    required this.images,
    super.isFavorite,
  });

  CafeDetail.empty()
      : cafeDescription = '',
        cafeNumber = '',
        menus = [],
        schedules = [],
        images = [],
        super.empty();

  CafeDetail.full()
      : cafeDescription =
            '나동글 카페는 남양주에 위치한 창고형 카페입니다.\n버려진 창고를 개조해 내부가 넓어 단체로 모임하기 좋습니다.\n강이 한 눈에 보이는 루프탑에서 자연을 느껴보세요.',
        cafeNumber = '031-123-1234',
        menus = [],
        schedules = [
          CafeSchedule.full(weekDayName: '월'),
          CafeSchedule.full(weekDayName: '화'),
          CafeSchedule.full(weekDayName: '수'),
          CafeSchedule.full(weekDayName: '목'),
          CafeSchedule.full(weekDayName: '금'),
          CafeSchedule.full(weekDayName: '토'),
          CafeSchedule.full(weekDayName: '일'),
        ],
        images = [],
        super.full();

  factory CafeDetail.fromJson(Map<String, dynamic> json) =>
      _$CafeDetailFromJson(json);
  Map<String, dynamic> toJson() => _$CafeDetailToJson(this);
}
