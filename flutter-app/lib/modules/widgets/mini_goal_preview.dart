import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logbook/shared/classes/goal.dart';
import 'package:logbook/shared/theme/main_colors.dart';
import 'package:logbook/shared/theme/text_styles.dart';

class MiniGoalPreview extends StatelessWidget {

  final Goal goal;

  const MiniGoalPreview({ 
    Key? key,
    required this.goal
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: ListTile(
        title: Text(goal.name, style: TextStyles.text),
        subtitle: goal.isComplete
            ? Text(DateFormat('dd/MM/yyyy').format(goal.completed_at!), style: TextStyles.text,)
            : Text("--/--/----", style: TextStyles.text,),
        leading: goal.isComplete
            ? const Icon(Icons.verified, color: MainColors.green,)
            : const Icon(Icons.close, color: MainColors.gray,),
      ),
    );
  }
}