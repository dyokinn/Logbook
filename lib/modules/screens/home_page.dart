import 'package:flutter/material.dart';
import 'package:logbook/shared/providers/user_provider.dart';
import 'package:logbook/shared/theme/main_colors.dart';
import 'package:logbook/shared/theme/text_styles.dart';
import 'package:provider/src/provider.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final state = context.watch<userState>();

    return Scaffold(
      backgroundColor: MainColors.blue,
      body: Container(
        height: 700,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(state.userInfo["photo"]),
            Text("Logou", style: TextStyles.title),
            Text(state.userInfo["email"], style: TextStyles.text),
            Text(state.userStats["mental"].toString(), style: TextStyles.text),
            ElevatedButton(
              child: Text("aoo"),
              onPressed: () => state.setUserInfoField("email", "Fábio Almeida"),
            )
          ],
        ),
      )
    );
  }
}