import 'package:flutter/material.dart';
import 'package:logbook/shared/controllers/login_controller.dart';
import 'package:logbook/shared/theme/main_colors.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final LoginController loginController = LoginController();

    return Scaffold(
      backgroundColor: MainColors.black,
      body: Center(
        child: Text("Logou")
      ),
    );
  }
}