// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CafeSchedule _$CafeScheduleFromJson(Map<String, dynamic> json) => CafeSchedule(
      weekDayName: json['weekDayName'] as String,
      isOpen: json['open'] as bool,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      breakStartTime: json['breakStartTime'] as String,
      breakEndTime: json['breakEndTime'] as String,
    );

Map<String, dynamic> _$CafeScheduleToJson(CafeSchedule instance) =>
    <String, dynamic>{
      'weekDayName': instance.weekDayName,
      'open': instance.isOpen,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'breakStartTime': instance.breakStartTime,
      'breakEndTime': instance.breakEndTime,
    };
