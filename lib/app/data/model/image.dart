import 'package:json_annotation/json_annotation.dart';

part 'image.g.dart';

@JsonSerializable()
class CafeImage {
  @JsonKey(name: 'image')
  String imageUrl;
  @JsonKey(name: 'name')
  String imageName;
  @JsonKey(name: 'type')
  String imageType;

  CafeImage({
    required this.imageUrl,
    required this.imageName,
    required this.imageType,
  });

  CafeImage.empty()
      : imageUrl = '',
        imageName = '',
        imageType = '';

  factory CafeImage.fromJson(Map<String, dynamic> json) =>
      _$CafeImageFromJson(json);
  Map<String, dynamic> toJson() => _$CafeImageToJson(this);
}
