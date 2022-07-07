import 'package:flutter/material.dart';
import 'package:logbook/shared/theme/main_colors.dart';
import 'package:logbook/shared/theme/text_styles.dart';
import 'package:provider/provider.dart';

import '../../shared/providers/login_provider.dart';

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // Puxando o tamanho da tela
    final size = MediaQuery.of(context).size;

    final LoginProvider loginProvider = context.read<LoginProvider>();
    
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
                  "Seja bem vindo almirante!", 
                  style: TextStyles.title,
                  textAlign: TextAlign.center,
                ),
              ),
                SizedBox(
                  height: size.height * 0.1,
                  width: size.width * 0.6,
                  child: ElevatedButton(
                    onPressed: () => loginProvider.handleLogin(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Entrar com o Google",
                        ),
                        Image.asset(
                          "assets/images/google-logo.png",
                          height: 30,
                          width: 30,
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(primary: MainColors.gray, textStyle: TextStyles.text),
                  ),
                )

            ],
          )
      )
      );
  }
}