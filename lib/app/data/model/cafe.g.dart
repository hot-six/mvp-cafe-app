// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cafe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cafe _$CafeFromJson(Map<String, dynamic> json) => Cafe(
      id: json['cafeId'] as int,
      cafeName: json['name'] as String,
      cafeAddress: json['address'] as String,
      mainSchedule:
          CafeSchedule.fromJson(json['mainSchedule'] as Map<String, dynamic>),
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      cafeTypes: (json['types'] as List<dynamic>)
          .map((e) => CafeType.fromJson(e as Map<String, dynamic>))
          .toList(),
      openType: $enumDecode(_$CafeOpenTypeEnumMap, json['openType']),
      isFavorite: json['is_favorite'] as bool?,
    );

Map<String, dynamic> _$CafeToJson(Cafe instance) => <String, dynamic>{
      'cafeId': instance.id,
      'name': instance.cafeName,
      'address': instance.cafeAddress,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'mainSchedule': instance.mainSchedule,
      'openType': _$CafeOpenTypeEnumMap[instance.openType]!,
      'types': instance.cafeTypes,
      'is_favorite': instance.isFavorite,
    };

const _$CafeOpenTypeEnumMap = {
  CafeOpenType.BEFORE_OPEN: 'BEFORE_OPEN',
  CafeOpenType.OPEN: 'OPEN',
  CafeOpenType.CLOSED: 'CLOSED',
  CafeOpenType.BREAK_TIME: 'BREAK_TIME',
  CafeOpenType.NA: 'NA',
};

CafeTile _$CafeTileFromJson(Map<String, dynamic> json) => CafeTile(
      id: json['cafeId'] as int,
      cafeName: json['name'] as String,
      cafeAddress: json['address'] as String,
      mainSchedule:
          CafeSchedule.fromJson(json['mainSchedule'] as Map<String, dynamic>),
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      cafeTypes: (json['types'] as List<dynamic>)
          .map((e) => CafeType.fromJson(e as Map<String, dynamic>))
          .toList(),
      openType: $enumDecode(_$CafeOpenTypeEnumMap, json['openType']),
      accuracy: (json['accuracy'] as num).toDouble(),
      isFavorite: json['is_favorite'] as bool?,
      thumbnail: json['thumbnail'] == null
          ? null
          : CafeImage.fromJson(json['thumbnail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CafeTileToJson(CafeTile instance) => <String, dynamic>{
      'cafeId': instance.id,
      'name': instance.cafeName,
      'address': instance.cafeAddress,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'mainSchedule': instance.mainSchedule,
      'openType': _$CafeOpenTypeEnumMap[instance.openType]!,
      'types': instance.cafeTypes,
      'is_favorite': instance.isFavorite,
      'accuracy': instance.accuracy,
      'thumbnail': instance.thumbnail,
    };

CafeDetail _$CafeDetailFromJson(Map<String, dynamic> json) => CafeDetail(
      id: json['cafeId'] as int,
      cafeName: json['name'] as String,
      cafeAddress: json['address'] as String,
      mainSchedule:
          CafeSchedule.fromJson(json['mainSchedule'] as Map<String, dynamic>),
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      cafeTypes: (json['types'] as List<dynamic>)
          .map((e) => CafeType.fromJson(e as Map<String, dynamic>))
          .toList(),
      openType: $enumDecode(_$CafeOpenTypeEnumMap, json['openType']),
      cafeDescription: json['description'] as String?,
      cafeNumber: json['number'] as String,
      menus: (json['menus'] as List<dynamic>)
          .map((e) => Menu.fromJson(e as Map<String, dynamic>))
          .toList(),
      schedules: (json['schedules'] as List<dynamic>)
          .map((e) => CafeSchedule.fromJson(e as Map<String, dynamic>))
          .toList(),
      images: (json['images'] as List<dynamic>)
          .map((e) => CafeImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      isFavorite: json['is_favorite'] as bool?,
    );

Map<String, dynamic> _$CafeDetailToJson(CafeDetail instance) =>
    <String, dynamic>{
      'cafeId': instance.id,
      'name': instance.cafeName,
      'address': instance.cafeAddress,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'mainSchedule': instance.mainSchedule,
      'openType': _$CafeOpenTypeEnumMap[instance.openType]!,
      'types': instance.cafeTypes,
      'is_favorite': instance.isFavorite,
      'description': instance.cafeDescription,
      'number': instance.cafeNumber,
      'menus': instance.menus,
      'schedules': instance.schedules,
      'images': instance.images,
    };
