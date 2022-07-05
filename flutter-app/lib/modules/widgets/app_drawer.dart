import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logbook/shared/providers/login_provider.dart';
import 'package:logbook/shared/theme/main_colors.dart';
import 'package:logbook/shared/theme/text_styles.dart';
import 'package:provider/src/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final loginProvider = context.read<LoginProvider>();
    final size = MediaQuery.of(context).size;

    return Drawer(
      child: Container(
        color: MainColors.black, 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(loginProvider.photo),
            Text(loginProvider.name, style: TextStyles.text),
            ElevatedButton(
                  child: Text("Login com o Google"),
                  onPressed: () async  {await loginProvider.handleLogout(context);},
                  style: ElevatedButton.styleFrom(
                    primary: MainColors.gray,
                    textStyle: TextStyles.text, 
                    fixedSize: Size(
                      size.width * 0.6,
                      size.height * 0.08
                    )
                  ),
                ),
          ],
        ),
    )
    );
  }
}