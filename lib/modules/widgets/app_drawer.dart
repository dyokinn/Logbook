import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logbook/shared/providers/user_provider.dart';
import 'package:logbook/shared/theme/main_colors.dart';
import 'package:provider/src/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final state = context.read<userState>();

    return Drawer(
      child: Scaffold(
        backgroundColor: MainColors.black, 
        floatingActionButton: ElevatedButton(
          child: Icon(Icons.drive_file_rename_outline_sharp),
          onPressed: () => print("aoo"),
        ),
        body: Column(
          children: [
            Image.network(state.userInfo["photo"]),
          ],
        ),
    )
    );
  }
}