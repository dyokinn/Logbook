import 'package:flutter/material.dart';
import 'package:logbook/shared/classes/goal_step.dart';
import 'package:logbook/shared/providers/goals_provider.dart';
import 'package:logbook/shared/providers/login_provider.dart';
import 'package:logbook/shared/theme/main_colors.dart';
import 'package:logbook/shared/theme/text_styles.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Alerts {

  static popSuccess(BuildContext context){
   Alert(
    style: AlertStyle(
      backgroundColor: MainColors.gray,
      titleStyle: TextStyles.text
    ),
    context: context,
    title: "Sucesso!",
    desc: "Dados atualizados!",
    buttons: [
      DialogButton(
          child: const Text(
            "Voltar",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
              Navigator.pop(context);
          },
      )
    ]
    ).show();
 } 

  static popCreateStepForm(BuildContext context){
    final goalsProvider = context.read<GoalsProvider>();
    final loginProvider = context.read<LoginProvider>();
    GoalStep step = GoalStep(text: "", isComplete: false);

    Alert(
      style: AlertStyle(
      backgroundColor: MainColors.gray,
      titleStyle: TextStyles.text,
      alertBorder: Border.all(style: BorderStyle.none)
      
      ),
      context: context,
      title: "Adicionar Etapa",
      content: Column(
        children: <Widget>[
          TextField(
            onChanged: (String newValue) {
              step.text = newValue;
            },
            style: TextStyles.text,
            decoration: InputDecoration(
              labelText: 'Nome',
              labelStyle: TextStyles.fieldText
            ),
          ),
        ],
      ),
      buttons: [
        DialogButton(
          onPressed: () async {
            await goalsProvider.addGoalStep(loginProvider.googleId, step);
            Navigator.pop(context);
          },
          color: MainColors.green,
          child: const Icon(Icons.send,)
        )
      ]
    ).show();
  }
}