import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logbook/modules/widgets/alerts.dart';
import 'package:logbook/modules/widgets/custom_button.dart';
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
      height: size.height * 0.5,
      child: goalsProvider.activeGoal.steps.isEmpty
      ? ListView(
        shrinkWrap: true,
        children: [
          ListTile(
            title: Text("Sem etapas definidas", style: TextStyles.heading,),
            subtitle: Text("Use o botão ao lado ou crie etapas", style: TextStyles.text,),
            trailing: CustomButton(
              icon: goalsProvider.activeGoal.isComplete
              ? Icons.toggle_on_outlined
              : Icons.toggle_off_outlined,
              onPressed: () => goalsProvider.toggleActiveGoalStatus(loginProvider.googleId), 
              size: const Size(50, 40)
            ),
          ),
          ListTile(
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: MainColors.gray, width: 1,),
              borderRadius: BorderRadius.circular(10),
            ),
            title: const Center(child: Icon(Icons.add, color: MainColors.green,)),
            onTap: () => Alerts.popCreateStepForm(context),
          )
        ]
      )
      : ListView(
        shrinkWrap: true,
        children: isCreationAllowed
        ? goalsProvider.activeGoal.steps.mapIndexed((index, e) => ListTile(
          onTap: () => goalsProvider.toggleGoalStep(loginProvider.googleId, index, e.isComplete),
          title: Text(e.text, style: TextStyles.text,),
          subtitle: e.isComplete
          ? Text(DateFormat('dd/MM/yyyy').format(e.completedAt!), style: TextStyles.text,)
          : Text("--/--/----", style: TextStyles.text,),
          leading: e.isComplete
          ? const Icon(Icons.verified, color: MainColors.green,)
          : const Icon(Icons.close, color: MainColors.gray,),
          trailing: GestureDetector(
            onTap: () async {
              await goalsProvider.removeGoalStep(loginProvider.googleId, e);

            },
            child: const Icon(Icons.delete, color: MainColors.red,),
          ),
        )).toList() + [ListTile(
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: MainColors.gray, width: 1,),
            borderRadius: BorderRadius.circular(10),
          ),
          title: const Center(child: Icon(Icons.add, color: MainColors.green,)),
          onTap: () => Alerts.popCreateStepForm(context),
        )]
        : goalsProvider.activeGoal.steps.mapIndexed((index, e) => ListTile(
          onTap: () => goalsProvider.toggleGoalStep(loginProvider.googleId, index, e.isComplete),
          title: Text(e.text, style: TextStyles.text,),
          subtitle: e.isComplete
          ? Text(DateFormat('dd/MM/yyyy').format(e.completedAt!), style: TextStyles.text,)
          : Text("--/--/----", style: TextStyles.text,),
          leading: e.isComplete
          ? const Icon(Icons.verified, color: MainColors.green,)
          : const Icon(Icons.close, color: MainColors.gray,),
        )).toList()
      ),
    );
  }
}