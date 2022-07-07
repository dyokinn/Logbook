import 'dart:ffi';
import 'package:json_annotation/json_annotation.dart';

part'log.g.dart';

@JsonSerializable()
class Log{
  int? id;
  String title;
  String text;
  DateTime created_at;
  DateTime? completed_at;
  double mental;
  double physical;
  double social;
  double professional;

  Log({
    this.id,
    required this.title,
    required this.text,
    required this.created_at,
    this.completed_at,
    required this.mental,
    required this.physical,
    required this.social,
    required this.professional,
  });

  factory Log.fromJson(Map<String, dynamic> data) => _$LogFromJson(data);

  Map<String, dynamic> toJson() => _$LogToJson(this);
}