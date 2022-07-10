import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logbook/modules/screens/log_view.dart';
import 'package:logbook/shared/providers/login_provider.dart';
import 'package:logbook/shared/providers/logs_provider.dart';
import 'package:logbook/shared/theme/main_colors.dart';
import 'package:logbook/shared/theme/text_styles.dart';
import 'package:provider/provider.dart';

import '../../shared/classes/log.dart';

class LogPreview extends StatelessWidget {

  final Log log;

  const LogPreview({ 
    Key? key,
    required this.log
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    LogsProvider logsProvider = context.read<LogsProvider>();
    LoginProvider loginProvider = context.read<LoginProvider>();

    return Container(
      height: size.height * 0.2,
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: size.height * 0.04),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: MainColors.gray,
      ),
      child: ListTile(
        onTap: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(log.title, style: TextStyles.heading,),
          content: Text('O que você deseja fazer, almirante?', style: TextStyles.text),
          backgroundColor: MainColors.gray,
          actions: <Widget>[
            IconButton(
              onPressed: () {
                logsProvider.setActiveLog(log);
                Navigator.pushReplacementNamed(context, "/log-view");
                },
              icon: Icon(Icons.remove_red_eye, color: MainColors.blue,),
            ),
            IconButton(
              onPressed: () => Navigator.pushReplacementNamed(context, "/create-log"),
              icon: Icon(Icons.edit, color: MainColors.green,),
            ),
            IconButton(
              onPressed: () async {
                logsProvider.deleteLog(loginProvider.googleId, log);
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
                child: Text(log.title, overflow: TextOverflow.ellipsis, style: TextStyles.heading)
              ),
              SizedBox(
                width: size.width * 0.3,
                child: Text(DateFormat('dd/MM/yyyy').format(log.created_at), textAlign: TextAlign.right, style: TextStyles.heading)
              ),
    
            ],
          ),
        ),
        subtitle: Container(
          height: size.height * 0.1,
          margin: EdgeInsets.only(left: size.width * 0.05, right: size.width * 0.05),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 14.0),
                        child: Icon(Icons.self_improvement, color: MainColors.green, size: 30),
                      ),
                      Text(log.mental.toString(), style: TextStyles.text,)
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 14.0),
                        child: Icon(Icons.sports_gymnastics_sharp, color: MainColors.green,size: 30),
                      ),
                      Text(log.physical.toString(), style: TextStyles.text,)
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 14.0),
                        child: Icon(Icons.work, color: MainColors.green,size: 30),
                      ),
                      Text(log.professional.toString(), style: TextStyles.text,)
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 14.0),
                        child: Icon(Icons.people_alt_outlined, color: MainColors.green,size: 30),
                      ),
                      Text(log.social.toString(), style: TextStyles.text,)
                    ],
                  ),
                ],
              ),
              log.isMemorable 
              ? Center(child: Icon(Icons.workspace_premium, color: MainColors.green,size: 30))
              : Center(child: Icon(Icons.workspace_premium, color: MainColors.black,size: 30)),
            ],
          ),
        ),
      ),
    );
  }
}