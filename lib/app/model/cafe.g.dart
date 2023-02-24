// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cafe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cafe _$CafeFromJson(Map<String, dynamic> json) => Cafe(
      id: json['cafeId'] as int,
      cafeName: json['name'] as String,
      cafeDescription: json['description'] as String,
      cafeAddress: json['address'] as String,
      cafeNumber: json['number'] as String,
      mainSchedule:
          CafeSchedule.fromJson(json['mainSchedule'] as Map<String, dynamic>),
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      menus: (json['menus'] as List<dynamic>)
          .map((e) => Menu.fromJson(e as Map<String, dynamic>))
          .toList(),
      schedules: (json['schedules'] as List<dynamic>)
          .map((e) => CafeSchedule.fromJson(e as Map<String, dynamic>))
          .toList(),
      types: (json['types'] as List<dynamic>)
          .map((e) => CafeType.fromJson(e as Map<String, dynamic>))
          .toList(),
      thumbnail: CafeImage.fromJson(json['thumbnail'] as Map<String, dynamic>),
      images: (json['images'] as List<dynamic>)
          .map((e) => CafeImage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CafeToJson(Cafe instance) => <String, dynamic>{
      'cafeId': instance.id,
      'name': instance.cafeName,
      'description': instance.cafeDescription,
      'address': instance.cafeAddress,
      'number': instance.cafeNumber,
      'mainSchedule': instance.mainSchedule,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'menus': instance.menus,
      'schedules': instance.schedules,
      'types': instance.types,
      'thumbnail': instance.thumbnail,
      'images': instance.images,
    };
