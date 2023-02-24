import 'package:json_annotation/json_annotation.dart';

part 'type.g.dart';

@JsonSerializable()
class CafeType {
  @JsonKey(name: "category")
  String category;
  @JsonKey(name: "type")
  String type;
  @JsonKey(name: "typeName")
  String typeName;

  CafeType({
    required this.category,
    required this.type,
    required this.typeName,
  });

  factory CafeType.fromJson(Map<String, dynamic> json) =>
      _$CafeTypeFromJson(json);
  Map<String, dynamic> toJson() => _$CafeTypeToJson(this);
}
