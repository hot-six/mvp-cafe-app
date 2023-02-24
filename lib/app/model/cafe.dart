import 'package:json_annotation/json_annotation.dart';
import 'package:nado_client_mvp/app/model/image.dart';
import 'package:nado_client_mvp/app/model/menu.dart';
import 'package:nado_client_mvp/app/model/schedule.dart';
import 'package:nado_client_mvp/app/model/type.dart';

part 'cafe.g.dart';

@JsonSerializable()
class Cafe {
  @JsonKey(name: "cafeId")
  int id;
  @JsonKey(name: "name")
  String cafeName;
  @JsonKey(name: "description")
  String cafeDescription;
  @JsonKey(name: "address")
  String cafeAddress;
  @JsonKey(name: "number")
  String cafeNumber;
  @JsonKey(name: "mainSchedule")
  CafeSchedule mainSchedule;
  @JsonKey(name: "latitude")
  double latitude;
  @JsonKey(name: "longitude")
  double longitude;
  @JsonKey(name: "menus")
  List<Menu> menus;
  @JsonKey(name: "schedules")
  List<CafeSchedule> schedules;
  @JsonKey(name: "types")
  List<CafeType> types;
  @JsonKey(name: "thumbnail")
  CafeImage thumbnail;
  @JsonKey(name: "images")
  List<CafeImage> images;

  Cafe({
    required this.id,
    required this.cafeName,
    required this.cafeDescription,
    required this.cafeAddress,
    required this.cafeNumber,
    required this.mainSchedule,
    required this.latitude,
    required this.longitude,
    required this.menus,
    required this.schedules,
    required this.types,
    required this.thumbnail,
    required this.images,
  });

  factory Cafe.fromJson(Map<String, dynamic> json) => _$CafeFromJson(json);
  Map<String, dynamic> toJson() => _$CafeToJson(this);
}
