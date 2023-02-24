// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CafeImage _$CafeImageFromJson(Map<String, dynamic> json) => CafeImage(
      imageUrl: json['image'] as String,
      imageName: json['name'] as String,
      imageType: json['type'] as String,
    );

Map<String, dynamic> _$CafeImageToJson(CafeImage instance) => <String, dynamic>{
      'image': instance.imageUrl,
      'name': instance.imageName,
      'type': instance.imageType,
    };
