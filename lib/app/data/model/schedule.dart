import 'package:json_annotation/json_annotation.dart';

part 'schedule.g.dart';

@JsonSerializable()
class CafeSchedule {
  @JsonKey(name: 'weekDayName')
  String weekDayName;
  @JsonKey(name: 'open')
  bool isOpen;
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

  CafeSchedule.empty()
      : weekDayName = "",
        isOpen = false,
        startTime = "",
        endTime = "",
        breakStartTime = "",
        breakEndTime = "";

  CafeSchedule.full({required String weekDayName})
      : weekDayName = weekDayName,
        isOpen = true,
        startTime = "10:00",
        endTime = "20:00",
        breakStartTime = "00:00",
        breakEndTime = "00:00";

  factory CafeSchedule.fromJson(Map<String, dynamic> json) =>
      _$CafeScheduleFromJson(json);
  Map<String, dynamic> toJson() => _$CafeScheduleToJson(this);
}
