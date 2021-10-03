import 'package:flutter/material.dart';
import 'package:logbook/shared/theme/main_colors.dart';
import 'package:logbook/shared/theme/text_styles.dart';

class LogsTab extends StatelessWidget {
  const LogsTab({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColors.black,
      floatingActionButton: ElevatedButton(
        child: Icon(Icons.drive_file_rename_outline_sharp),
        onPressed: () => print("aoo"),
        style: ElevatedButton.styleFrom(
          primary: MainColors.blue
        ),
      ),
      body: Center(child: Text("aoo, é o logas", style: TextStyles.text,)),
    );
  }
}