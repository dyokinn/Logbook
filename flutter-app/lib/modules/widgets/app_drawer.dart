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
            Column(
              children: [
                 Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(loginProvider.photo),
                      fit: BoxFit.fill
                    )
                  ),
                ), 
                Text(loginProvider.name, style: TextStyles.drawer),
              ],
            ),
            Container(
              height: size.height * 0.07,
              width: size.width * 0.5,
              decoration: const BoxDecoration(
                color: MainColors.red,
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: Center(
                child: ListTile(
                  title: Text("Desembarcar", style: TextStyles.drawer),
                  onTap: () async  {await loginProvider.handleLogout(context);},
                  trailing: const Icon(Icons.logout, color: MainColors.gray),
                ),
              ),
            )
          ],
        ),
    )
    );
  }
}