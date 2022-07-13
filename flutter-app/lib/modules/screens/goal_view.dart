import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logbook/modules/screens/home_page.dart';
import 'package:logbook/modules/widgets/app_bar_with_back.dart';
import 'package:logbook/modules/widgets/app_drawer.dart';
import 'package:logbook/modules/widgets/step_viewer.dart';
import 'package:logbook/shared/providers/goals_provider.dart';
import 'package:logbook/shared/providers/logs_provider.dart';
import 'package:logbook/shared/theme/main_colors.dart';
import 'package:logbook/shared/theme/text_styles.dart';
import 'package:provider/provider.dart';

class GoalView extends StatelessWidget {
  const GoalView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GoalsProvider goalsProvider = context.watch<GoalsProvider>();

    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBarWithBack(pageToGo: HomePage()),
      drawer: AppDrawer(),
      backgroundColor: MainColors.black,
      body:  Container(
          margin: EdgeInsets.only(left: size.width * 0.1, right: size.width * 0.1),
          child: ListView(
            shrinkWrap: true,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: size.height * 0.2,
                    width: size.width * 0.55,
                    alignment: Alignment.centerLeft,
                    child: Text(goalsProvider.activeGoal.name, maxLines: 3, overflow: TextOverflow.clip, style: TextStyles.title,)),
                  Visibility(
                    child: SizedBox(
                      height: size.height * 0.2,
                      width: size.width * 0.25,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.verified, color: MainColors.green,),
                          Text("Completa em " + DateFormat('dd/MM/yyyy').format(goalsProvider.activeGoal.completed_at ?? DateTime.now()), style: TextStyles.text,)
                        ],
                      ),
                    ),
                    replacement: SizedBox(
                      height: size.height * 0.2,
                      width: size.width * 0.25,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.close, color: MainColors.red,),
                          Text("Incompleta", style: TextStyles.text)
                        ],
                      ),
                    ),
                    visible: goalsProvider.activeGoal.isComplete,
                  )
                ],
              ),
              Expanded(child: Text(goalsProvider.activeGoal.description, overflow: TextOverflow.visible, style: TextStyles.heading)),

              Text("Etapas", style: TextStyles.heading,),
              StepViewer(isCreationAllowed: true)
            ],
          ),
        ),
      );
  }
}