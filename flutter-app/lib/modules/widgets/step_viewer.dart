import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logbook/modules/widgets/alerts.dart';
import 'package:logbook/shared/providers/goals_provider.dart';
import 'package:logbook/shared/providers/login_provider.dart';
import 'package:logbook/shared/theme/main_colors.dart';
import 'package:logbook/shared/theme/text_styles.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class StepViewer extends StatelessWidget {

  final bool isCreationAllowed;

  const StepViewer({ 
    Key? key ,
    required this.isCreationAllowed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GoalsProvider goalsProvider = context.watch<GoalsProvider>();
    LoginProvider loginProvider = context.watch<LoginProvider>();

    final size = MediaQuery.of(context).size;
    
    return SizedBox(
      height: size.height * 0.4,
      child: ListView(
        shrinkWrap: true,
        children: isCreationAllowed
        ? goalsProvider.activeGoal.steps.mapIndexed((index, e) => ListTile(
          onTap: () => goalsProvider.toggleGoalStep(loginProvider.googleId, index, e.isComplete),
          title: Text(e.text),
          subtitle: e.isComplete
          ? Text(DateFormat('dd/MM/yyyy').format(e.completedAt!))
          : Text("--/--/----"),
          leading: e.isComplete
          ? Icon(Icons.verified)
          : Icon(Icons.close),
          trailing: GestureDetector(
            onTap: () async {
              await goalsProvider.removeGoalStep(loginProvider.googleId, e);

            },
            child: Icon(Icons.delete, color: MainColors.red,),
          ),
        )).toList() + [ListTile(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: MainColors.green, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          title: Center(child: Icon(Icons.add)),
          onTap: () => Alerts.popCreateStepForm(context),
        )]
        : goalsProvider.activeGoal.steps.mapIndexed((index, e) => ListTile(
          onTap: () => goalsProvider.toggleGoalStep(loginProvider.googleId, index, e.isComplete),
          title: Text(e.text),
          subtitle: e.isComplete
          ? Text(DateFormat('dd/MM/yyyy').format(e.completedAt!))
          : Text("--/--/----"),
          leading: e.isComplete
          ? Icon(Icons.verified)
          : Icon(Icons.close),
        )).toList()
      ),
    );
  }
}