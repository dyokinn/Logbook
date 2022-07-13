import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logbook/modules/screens/home_page.dart';
import 'package:logbook/modules/widgets/app_bar_with_back.dart';
import 'package:logbook/modules/widgets/custom_button.dart';
import 'package:logbook/modules/widgets/input.dart';
import 'package:logbook/modules/widgets/input_with_controller.dart';
import 'package:logbook/shared/classes/goal.dart';
import 'package:logbook/shared/providers/goals_provider.dart';
import 'package:logbook/shared/providers/login_provider.dart';
import 'package:logbook/shared/providers/logs_provider.dart';
import 'package:logbook/shared/theme/main_colors.dart';
import 'package:logbook/shared/theme/text_styles.dart';
import 'package:provider/provider.dart';

class CreateGoal extends StatefulWidget {
  const CreateGoal({ Key? key }) : super(key: key);

  @override
  State<CreateGoal> createState() => _CreateGoalState();
}

class _CreateGoalState extends State<CreateGoal> {
  final _formKey = GlobalKey<FormState>();

  String? name;
  String? description;
  DateTime? created_at;
  TextEditingController created_atText = TextEditingController();
  bool isComplete = false;
  DateTime? completed_at;

  @override
  Widget build(BuildContext context) {

    LoginProvider loginProvider = context.read<LoginProvider>();
    GoalsProvider goalsProvider = context.read<GoalsProvider>();

    final size = MediaQuery.of(context).size;

    return Hero(
      tag: "create",
        child: Scaffold(
          resizeToAvoidBottomInset: false,
        appBar: AppBarWithBack(pageToGo: HomePage()),
        backgroundColor: MainColors.black,
        body: Container(
          width: size.width * 0.8,
          margin: EdgeInsets.only(left: size.width * 0.1),
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Input(
                    height: size.height * 0.1,
                    width: size.width * 0.8,
                    label: "Nome da Meta",
                    onChanged: (value) {
                      setState(() {
                        name = value;
                      });
                    },
                  ),
                ),
                Input(
                      label: "Tem anotações sobre a meta?", 
                      height: size.height * 0.35, 
                      width: size.width * 0.8,
                      onChanged: (value) {
                        setState(() {
                          description = value;
                        });
                      },
                    ),
                SizedBox(
                  height: size.height * 0.2,
                  width: size.width * 0.8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InputWithController( 
                        label: "Data de criação da meta",
                        height: size.height * 0.1,
                        width: size.width * 0.54,
                        enabled: false, 
                        controller: created_atText,
                      ),
                      CustomButton(
                        icon: Icons.date_range,
                        size: Size(size.width * 0.1, size.height * 0.05),
                        onPressed: ()async {
                          showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2022),
                                lastDate: DateTime(2030))
                            .then((date) {
                          setState(() {
                            created_at = date;
                            created_atText.text =  DateFormat('dd/MM/yyyy').format(date!);
                          });
                        });
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.08,
                  child: Center(
                    child: CustomButton(
                      icon: Icons.send,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {

                          Goal goal = Goal(
                            name: name!, 
                            description: description!, 
                            created_at: created_at!, 
                            isComplete: isComplete
                          );
                    
                          await goalsProvider.createGoal(loginProvider.googleId, goal);
                          Navigator.pushReplacementNamed(context, "/home");
                        }
                    
                      }, 
                      size: Size(size.width * 0.5, size.height * 0.08)
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        )
    );
  }
}