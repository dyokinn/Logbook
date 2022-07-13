import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logbook/modules/screens/log_view.dart';
import 'package:logbook/shared/classes/goal.dart';
import 'package:logbook/shared/providers/goals_provider.dart';
import 'package:logbook/shared/providers/login_provider.dart';
import 'package:logbook/shared/providers/logs_provider.dart';
import 'package:logbook/shared/theme/main_colors.dart';
import 'package:logbook/shared/theme/text_styles.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../shared/classes/log.dart';

class GoalPreview extends StatelessWidget {

  final Goal goal;

  const GoalPreview({ 
    Key? key,
    required this.goal
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    GoalsProvider goalsProvider = context.read<GoalsProvider>();
    LoginProvider loginProvider = context.read<LoginProvider>();

    return Container(
      height: size.height * 0.25,
      alignment: Alignment.topCenter,
      margin: EdgeInsets.only(top: size.height * 0.04),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: MainColors.gray,
      ),
      child: ListTile(
        onTap: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(goal.name, style: TextStyles.heading,),
          content: Text('O que você deseja fazer, almirante?', style: TextStyles.text),
          backgroundColor: MainColors.gray,
          actions: <Widget>[
            IconButton(
              onPressed: () {
                goalsProvider.setActiveGoal(goal);
                Navigator.pushReplacementNamed(context, "/goal-view");
                },
              icon: Icon(Icons.remove_red_eye, color: MainColors.blue,),
            ),
            IconButton(
              onPressed: () {
                goalsProvider.setActiveGoal(goal);
                Navigator.pushReplacementNamed(context, "/goal-view");
                Navigator.pop(context);
              },
              icon: Icon(Icons.edit, color: MainColors.green,),
            ),
            IconButton(
              onPressed: () async {
                goalsProvider.deleteGoal(loginProvider.googleId, goal);
                Navigator.pop(context);
              },
              icon: Icon(Icons.delete, color: MainColors.red,),
            ),
          ],
        )),
        title: Padding(
          padding: const EdgeInsets.only(top:15.0, bottom: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: size.width * 0.45,
                child: Text(goal.name, overflow: TextOverflow.ellipsis, style: TextStyles.heading)
              ),
              SizedBox(
                width: size.width * 0.3,
                child: goal.isComplete 
              ? Center(child: Icon(Icons.verified_rounded, color: MainColors.green,size: 30))
              : Center(child: Icon(Icons.close, color: MainColors.red,size: 30)),
              ),
    
            ],
          ),
        ),
        subtitle: goal.steps.isEmpty
          ? Text("Sem etapas definidas!", style: TextStyles.text,)
          : StepProgressIndicator(
              totalSteps: goal.steps.length,
              currentStep: goal.steps.indexWhere((goal) => goal.isComplete) == -1
                          ? 0
                          : goal.steps.indexWhere((goal) => goal.isComplete)
              ,
              size: 36,
              selectedColor: MainColors.green,
              unselectedColor: MainColors.gray,
              customStep: (index, color, _) => color == MainColors.green
                  ? Container(
                      color: color,
                      child: Icon(
                      Icons.check,
                      color: Colors.white,
                      ),
                  )
                  : Container(
                      color: color,
                      child: Icon(
                      Icons.remove,
                      ),
                  ),
          ),
        ),
    );
  }
}