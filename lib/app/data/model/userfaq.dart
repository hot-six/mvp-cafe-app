import 'package:json_annotation/json_annotation.dart';

part 'userfaq.g.dart';

enum FAQDivisionType { FEEDBACK, REGION, NA }

@JsonSerializable()
class UserFAQ {
  @JsonKey(name: 'division')
  FAQDivisionType faqDivision;

  @JsonKey(name: 'title')
  String title;
  @JsonKey(name: 'content')
  String content;

  UserFAQ({
    required this.faqDivision,
    required this.title,
    required this.content,
  });

  UserFAQ.empty()
      : faqDivision = FAQDivisionType.NA,
        title = '',
        content = '';

  factory UserFAQ.fromJson(Map<String, dynamic> json) =>
      _$UserFAQFromJson(json);
  Map<String, dynamic> toJson() => _$UserFAQToJson(this);
}
