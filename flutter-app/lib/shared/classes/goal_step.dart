import 'package:json_annotation/json_annotation.dart';

part'goal_step.g.dart';


@JsonSerializable()


class GoalStep{
  String text;
  bool isComplete;
  DateTime? completedAt;

  GoalStep({
    required this.text,
    required this.isComplete,
    this.completedAt
  });

  factory GoalStep.fromJson(Map<String, dynamic> data) => _$GoalStepFromJson(data);

  Map<String, dynamic> toJson() => _$GoalStepToJson(this);
}