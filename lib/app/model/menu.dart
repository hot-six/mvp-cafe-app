import 'package:json_annotation/json_annotation.dart';

part 'menu.g.dart';

@JsonSerializable()
class Menu {
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'price')
  int price;

  Menu({
    required this.name,
    required this.price,
  });

  factory Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json);
  Map<String, dynamic> toJson() => _$MenuToJson(this);
}
