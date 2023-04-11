import 'package:json_annotation/json_annotation.dart';

part 'type.g.dart';

enum CafeCategoryType {
  CAFE('카페'),
  SPACE('공간'),
  FACILITY('시설'),
  MOOD('분위기'),
  NA('');

  final String displayName;

  const CafeCategoryType(this.displayName);
}

@JsonSerializable()
class CafeType {
  @JsonKey(name: "category")
  CafeCategoryType category;
  @JsonKey(name: "type")
  String type;
  @JsonKey(name: "typeName")
  String typeName;
  @JsonKey(name: "selected")
  bool? isTypeSelected;

  CafeType({
    required this.category,
    required this.type,
    required this.typeName,
    this.isTypeSelected,
  });

  CafeType.empty()
      : category = CafeCategoryType.NA,
        type = '',
        typeName = '',
        isTypeSelected = false;

  CafeType.full({
    required CafeCategoryType category,
    required String type,
    required String typeName,
  })  : category = category,
        type = type,
        typeName = typeName,
        isTypeSelected = false;

  factory CafeType.fromJson(Map<String, dynamic> json) =>
      _$CafeTypeFromJson(json);
  Map<String, dynamic> toJson() => _$CafeTypeToJson(this);
}
