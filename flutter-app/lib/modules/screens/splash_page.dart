import 'package:flutter/material.dart';
import 'package:logbook/shared/controllers/login_controller.dart';
import 'package:logbook/shared/theme/main_colors.dart';

class SplashPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final LoginController loginController = LoginController();
    
    loginController.userAlreadyLogged(context);

    return Scaffold(
      backgroundColor: MainColors.black,
      body: Center(
        child: Image.asset(
          "assets/images/logo_with_text.png",
          height: 500,
          width: 500,
        )
      ),
    );
  }
}