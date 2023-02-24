import 'package:json_annotation/json_annotation.dart';

part 'schedule.g.dart';

@JsonSerializable()
class CafeSchedule {
  @JsonKey(name: 'weekDayName')
  String weekDayName;
  @JsonKey(name: 'openYn')
  String isOpen;
  @JsonKey(name: 'startTime')
  String startTime;
  @JsonKey(name: 'endTime')
  String endTime;
  @JsonKey(name: 'breakStartTime')
  String breakStartTime;
  @JsonKey(name: 'breakEndTime')
  String breakEndTime;

  CafeSchedule({
    required this.weekDayName,
    required this.isOpen,
    required this.startTime,
    required this.endTime,
    required this.breakStartTime,
    required this.breakEndTime,
  });

  factory CafeSchedule.fromJson(Map<String, dynamic> json) =>
      _$CafeScheduleFromJson(json);
  Map<String, dynamic> toJson() => _$CafeScheduleToJson(this);
}
