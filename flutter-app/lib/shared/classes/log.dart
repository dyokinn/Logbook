import 'dart:ffi';
import 'package:json_annotation/json_annotation.dart';

part'log.g.dart';

@JsonSerializable(explicitToJson: true)
class Log{
  String? id;
  String title;
  String text;
  DateTime created_at;
  bool isMemorable;
  double? lat;
  double? long;
  List<String> categs;
  int mental;
  int physical;
  int social;
  int professional;

  Log({
    this.id,
    required this.title,
    required this.text,
    required this.created_at,
    required this.isMemorable,
    this.lat,
    this.long,
    required this.categs,
    required this.mental,
    required this.physical,
    required this.social,
    required this.professional,
  });

  factory Log.fromJson(Map<String, dynamic> data) => _$LogFromJson(data);

  Map<String, dynamic> toJson() => _$LogToJson(this);
}