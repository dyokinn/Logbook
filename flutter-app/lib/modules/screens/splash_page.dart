import 'package:flutter/material.dart';
import 'package:logbook/shared/providers/login_provider.dart';
import 'package:logbook/shared/theme/main_colors.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final LoginProvider loginProvider = context.read<LoginProvider>();
    
    loginProvider.userAlreadyLogged(context);

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