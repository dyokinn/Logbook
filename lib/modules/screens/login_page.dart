import 'package:flutter/material.dart';
import 'package:logbook/shared/controllers/login_controller.dart';
import 'package:logbook/shared/theme/main_colors.dart';
import 'package:logbook/shared/theme/text_styles.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // Puxando o tamanho da tela
    final size = MediaQuery.of(context).size;

    final LoginController loginController = LoginController();
    
    return Scaffold(
      backgroundColor: MainColors.black,
      body: Container(
        margin: EdgeInsets.fromLTRB(0, size.height * 0.1, 0, 0),
        child: Column(
            children: [
              Image.asset(
                "assets/images/cais.png",
                height: 400,
                width: 400,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(size.height * 0.1, 0, size.height * 0.1, size.height * 0.1),
                child: Text(
                  "Seja bem vindo capitão!", 
                  style: TextStyles.title,
                  textAlign: TextAlign.center,
                ),
              ),
              Container(

                child: ElevatedButton(
                  child: Text("Login com o Google"),
                  onPressed: () => loginController.handleLogin(context),
                  style: ElevatedButton.styleFrom(
                    primary: MainColors.gray,
                    textStyle: TextStyles.text, 
                    fixedSize: Size(
                      size.width * 0.6,
                      size.height * 0.08
                    )
                  ),
                ),
              )
              
            ],
          )
      )
      );
  }
}