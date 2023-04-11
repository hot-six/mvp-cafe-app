// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CafeType _$CafeTypeFromJson(Map<String, dynamic> json) => CafeType(
      category: $enumDecode(_$CafeCategoryTypeEnumMap, json['category']),
      type: json['type'] as String,
      typeName: json['typeName'] as String,
      isTypeSelected: json['selected'] as bool?,
    );

Map<String, dynamic> _$CafeTypeToJson(CafeType instance) => <String, dynamic>{
      'category': _$CafeCategoryTypeEnumMap[instance.category]!,
      'type': instance.type,
      'typeName': instance.typeName,
      'selected': instance.isTypeSelected,
    };

const _$CafeCategoryTypeEnumMap = {
  CafeCategoryType.CAFE: 'CAFE',
  CafeCategoryType.SPACE: 'SPACE',
  CafeCategoryType.FACILITY: 'FACILITY',
  CafeCategoryType.MOOD: 'MOOD',
  CafeCategoryType.NA: 'NA',
};
