import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logbook/shared/providers/user_provider.dart';
import 'package:logbook/shared/theme/main_colors.dart';
import 'package:logbook/shared/theme/text_styles.dart';
import 'package:provider/src/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final state = context.read<userState>();

    return Drawer(
      child: Container(
        color: MainColors.black, 
        child: Column(
          children: [
            Text(state.userInfo["name"], style: TextStyles.text),
          ],
        ),
    )
    );
  }
}