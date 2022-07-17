import 'package:flutter/material.dart';
import 'package:logbook/shared/classes/goal.dart';
import 'package:logbook/shared/providers/goals_provider.dart';
import 'package:logbook/shared/providers/login_provider.dart';
import 'package:logbook/shared/theme/main_colors.dart';
import 'package:logbook/shared/theme/text_styles.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';


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
      height: size.height * 0.15,
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
              icon: const Icon(Icons.remove_red_eye, color: MainColors.blue,),
            ),
            IconButton(
              onPressed: () async {
                goalsProvider.deleteGoal(loginProvider.googleId, goal);
                Navigator.pop(context);
              },
              icon: const Icon(Icons.delete, color: MainColors.red,),
            ),
          ],
        )),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              height: size.height * 0.08,
              width: size.width * 0.55,
              child: Text(goal.name, textAlign: TextAlign.left, overflow: TextOverflow.ellipsis, style: TextStyles.heading)
            ),
            SizedBox(
              height: size.height * 0.08,
              width: size.width * 0.2,
              child: goal.isComplete 
            ? const Center(child: Icon(Icons.verified_rounded, color: MainColors.green,size: 30))
            : const Center(child: Icon(Icons.verified_rounded, color: MainColors.gray, size: 30)),
            ),
    
          ],
        ),
        subtitle: goal.steps.isEmpty
          ? Text("Sem rota definida!", textAlign: TextAlign.center, style: TextStyles.text,)
          : StepProgressIndicator(
              totalSteps: goal.steps.length,
              currentStep: goal.steps.lastIndexWhere((step) => step.isComplete) == -1
                ? 0
                : goal.steps.lastIndexWhere((step) => step.isComplete) + 1
              ,
              size: 36,
              selectedColor: MainColors.black,
              unselectedColor: MainColors.gray,
              customStep: (index, color, _) => color == MainColors.black
                  ? Container(
                      color: color,
                      child: const Icon(
                      Icons.check,
                      color: MainColors.green,
                      ),
                  )
                  : index == goal.steps.length - 1
                    ? Container(
                        color: color,
                        child: const Icon(
                        Icons.close,
                        color: MainColors.red,
                        size: 30,
                        ),
                    )
                    : Container(
                        color: color,
                        child: const Icon(
                        Icons.remove,
                        color: Colors.white70,
                        ),
                    ),
          ),
        ),
    );
  }
}