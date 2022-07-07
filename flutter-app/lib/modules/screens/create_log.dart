import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logbook/modules/widgets/app_drawer.dart';
import 'package:logbook/modules/widgets/custom_button.dart';
import 'package:logbook/modules/widgets/input.dart';
import 'package:logbook/shared/classes/log.dart';
import 'package:logbook/shared/providers/login_provider.dart';
import 'package:logbook/shared/providers/logs_provider.dart';
import 'package:logbook/shared/theme/main_colors.dart';
import 'package:provider/provider.dart';

class CreateLog extends StatefulWidget {
  const CreateLog({ Key? key }) : super(key: key);

  @override
  State<CreateLog> createState() => _CreateLogState();
}

class _CreateLogState extends State<CreateLog> {

  final _formKey = GlobalKey<FormState>();

  int? id;
  String? title;
  String? text;
  DateTime? created_at = DateTime.now();
  DateTime? completed_at;
  double? mental;
  double? physical;
  double? social;
  double? professional;
  
  @override
  Widget build(BuildContext context) {

    LoginProvider loginProvider = context.read<LoginProvider>();
    LogsProvider logsProvider = context.read<LogsProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Logbook"),
        leading: GestureDetector(child: Icon(Icons.arrow_back), onTap: () => Navigator.pop(context)),
        backgroundColor: MainColors.gray,
      ),
      backgroundColor: MainColors.black,
      body: Container(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Input(
                    height: 100,
                    width: 250,
                    label: "Nome do Registro",
                    onChanged: (value) {
                      setState(() {
                        title = value;
                      });
                    },
                  ),
                  Row(
                    children: [
                      Input(
                        label: "", 
                        height:100, 
                        width: 250, 
                        enabled: false, 
                        initialValue: DateFormat('dd/MM/yyyy').format(created_at!)),
                      CustomButton(
                        icon: Icons.date_range,
                        size: Size(40, 40),
                        onPressed: ()async {
                          showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2022),
                                lastDate: DateTime(2030))
                            .then((date) {
                          setState(() {
                            created_at = date;
                          });
                        });
                        },
                      )
                    ],
                  ),
                  
                ],
              ),
              Input(
                    label: "O que aconteceu, marujo?", 
                    height: 300, 
                    width: 400,
                    onChanged: (value) {
                      setState(() {
                        text = value;
                      });
                    },
                  ),
                  CustomButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        Log log = Log(
                          title: title!, 
                          text: text!, 
                          created_at: created_at!, 
                          mental: loginProvider.mental, 
                          physical: loginProvider.mental, 
                          social: loginProvider.mental, 
                          professional: loginProvider.professional);

                        await logsProvider.createLog(loginProvider.googleId, log);
                        Navigator.pushReplacementNamed(context, "/home");
                      }

                    }, 
                    size: Size(200, 250)
                  )
            ],
          ),
        ),
      )
    );
  }
}