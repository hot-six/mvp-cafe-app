// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userfaq.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserFAQ _$UserFAQFromJson(Map<String, dynamic> json) => UserFAQ(
      faqDivision: $enumDecode(_$FAQDivisionTypeEnumMap, json['division']),
      title: json['title'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$UserFAQToJson(UserFAQ instance) => <String, dynamic>{
      'division': _$FAQDivisionTypeEnumMap[instance.faqDivision]!,
      'title': instance.title,
      'content': instance.content,
    };

const _$FAQDivisionTypeEnumMap = {
  FAQDivisionType.FEEDBACK: 'FEEDBACK',
  FAQDivisionType.REGION: 'REGION',
  FAQDivisionType.NA: 'NA',
};
