import 'package:flutter/material.dart';
import 'package:logbook/shared/controllers/login_controller.dart';
import 'package:logbook/shared/theme/main_colors.dart';
import 'package:logbook/shared/theme/text_styles.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final LoginController loginController = LoginController();
    
    return Scaffold(
      backgroundColor: MainColors.black,
      body: Center(
          child: ElevatedButton(
            child: Text("Login com o Google"),
            onPressed: loginController.handleLogin,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(MainColors.gray),
              textStyle: MaterialStateProperty.all(TextStyles.text),
            ),
          ),
      ),
    );
  }
}