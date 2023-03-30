// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Menu _$MenuFromJson(Map<String, dynamic> json) => Menu(
      name: json['name'] as String,
      price: json['price'] as int,
      isSignature: json['isSignature'] as bool?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$MenuToJson(Menu instance) => <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'description': instance.description,
      'isSignature': instance.isSignature,
    };
