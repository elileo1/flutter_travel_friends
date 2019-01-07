// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'departure.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Departure _$DepartureFromJson(Map<String, dynamic> json) {
  return Departure(json['dateStr'] as String, json['dateValue'] as int,
      json['condition'] as String);
}

Map<String, dynamic> _$DepartureToJson(Departure instance) => <String, dynamic>{
      'dateStr': instance.dateStr,
      'dateValue': instance.dateValue,
      'condition': instance.condition
    };
