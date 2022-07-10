import 'package:flutter/material.dart';
import 'package:logbook/modules/screens/create_log.dart';
import 'package:logbook/modules/widgets/log_preview.dart';
import 'package:logbook/shared/classes/log.dart';
import 'package:logbook/shared/providers/login_provider.dart';
import 'package:logbook/shared/providers/logs_provider.dart';
import 'package:logbook/shared/theme/main_colors.dart';
import 'package:logbook/shared/theme/text_styles.dart';
import 'package:provider/provider.dart';

class LogsTab extends StatefulWidget {
  const LogsTab({ Key? key }) : super(key: key);

  @override
  _LogsTabState createState() => _LogsTabState();
}

class _LogsTabState extends State<LogsTab> {

  @override
  Widget build(BuildContext context) {

    LogsProvider logsProvider = context.watch<LogsProvider>();
    LoginProvider loginProvider = context.watch<LoginProvider>();

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: MainColors.black,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(context, PageRouteBuilder(
          pageBuilder: (context, __, ___) => CreateLog(), 
          transitionDuration: Duration(seconds: 1),
        )),
        backgroundColor: MainColors.blue,
        heroTag: "create-log",
      ),
      body: SizedBox(
        width: size.width,
        child: RefreshIndicator(
          onRefresh: () async {
            await logsProvider.updateLogList(loginProvider.googleId);
          },
          child: Container(
            width: size.width * 0.9,
            margin: EdgeInsets.only(left: size.width * 0.05),
            child: ListView(
              shrinkWrap: true,
              children: logsProvider.logs.map((log) => LogPreview(log: log)).toList()
              ,
            ),
          ),
        ),
      ),
    );
  }
}