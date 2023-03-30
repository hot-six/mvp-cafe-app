// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CafeType _$CafeTypeFromJson(Map<String, dynamic> json) => CafeType(
      category: json['category'] as String,
      type: json['type'] as String,
      typeName: json['typeName'] as String,
      isTypeSelected: json['selected'] as bool?,
    );

Map<String, dynamic> _$CafeTypeToJson(CafeType instance) => <String, dynamic>{
      'category': instance.category,
      'type': instance.type,
      'typeName': instance.typeName,
      'selected': instance.isTypeSelected,
    };
