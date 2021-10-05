import 'package:flutter/material.dart';
import 'package:logbook/shared/classes/log.dart';
import 'package:logbook/shared/controllers/logs_controller.dart';
import 'package:logbook/shared/theme/main_colors.dart';
import 'package:logbook/shared/theme/text_styles.dart';

class LogsTab extends StatefulWidget {
  const LogsTab({ Key? key }) : super(key: key);

  @override
  _LogsTabState createState() => _LogsTabState();
}

class _LogsTabState extends State<LogsTab> {

  // Atributos
  LogsController controller = LogsController();
  late Future<List<Log>> logs = controller.getLogs();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColors.black,
      floatingActionButton: ElevatedButton(
        child: Icon(Icons.drive_file_rename_outline_sharp),
        onPressed: () => setState(() {
          logs = controller.getLogs();
        }),
        style: ElevatedButton.styleFrom(
          primary: MainColors.blue
        ),
      ),
      body: Column(
        children: [
          Center(child: Text("aoo, é o logas", style: TextStyles.text,)),
          FutureBuilder(
              future: logs,
              builder: (BuildContext context, AsyncSnapshot<List<Log>> snapshot) {
                if (!snapshot.hasData){
                  return Column(
                    children: [
                      CircularProgressIndicator(),
                    ],
                  );
                }
                else if(snapshot.hasError){
                  return Column(
                    children: [
                      Text("Deu pau"),
                    ],
                  );
                }
                else{
                  print(snapshot.data);
                  return ListView(
                    shrinkWrap: true,
                    children: snapshot.data!.map((log) => 
                    ListTile(
                      title: Text(log.title, style: TextStyles.title),
                      subtitle: Text(log.text, style: TextStyles.text),
                    ),
                  ).toList());
                }
              },
          )
        ],
      ),
    );
  }
}