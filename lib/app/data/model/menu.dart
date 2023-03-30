import 'package:json_annotation/json_annotation.dart';

part 'menu.g.dart';

@JsonSerializable()
class Menu {
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'price')
  int price;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'isSignature')
  bool? isSignature;

  Menu({
    required this.name,
    required this.price,
    this.isSignature,
    this.description,
  });

  Menu.empty()
      : name = '',
        price = 0,
        description = '',
        isSignature = false;

  factory Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json);
  Map<String, dynamic> toJson() => _$MenuToJson(this);
}
