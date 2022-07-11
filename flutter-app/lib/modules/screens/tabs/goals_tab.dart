import 'package:flutter/material.dart';
import 'package:logbook/shared/providers/goals_provider.dart';
import 'package:logbook/shared/providers/login_provider.dart';
import 'package:logbook/shared/theme/main_colors.dart';
import 'package:logbook/shared/theme/text_styles.dart';
import 'package:provider/provider.dart';

class GoalsTab extends StatelessWidget {
  const GoalsTab({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

  GoalsProvider goalsProvider = context.watch<GoalsProvider>();
  LoginProvider loginProvider = context.watch<LoginProvider>();

  final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: MainColors.black,
      
      body: SizedBox(
        width: size.width,
        child: RefreshIndicator(
          onRefresh: () async {
            await goalsProvider.updateGoalList(loginProvider.googleId);
          },
          child: Container(
            width: size.width * 0.9,
            margin: EdgeInsets.only(left: size.width * 0.05),
            child: Column(
              children: [
                CheckboxListTile(
                  value: goalsProvider.includeCompletedGoals,
                  onChanged: (value){
                    goalsProvider.setIncludeComplete(value!);
                  },
                  title: Text("Incluir metas já atingidas", style: TextStyles.text,),
                  
                ),
                ListView(
                  shrinkWrap: true,
                  children: goalsProvider.filteredGoals.map((goal) => Text(goal!.name, style: TextStyles.text,)).toList()
                  ,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}