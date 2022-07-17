// ignore_for_file: implementation_imports

import 'package:flutter/material.dart';
import 'package:logbook/shared/providers/login_provider.dart';
import 'package:logbook/shared/theme/main_colors.dart';
import 'package:logbook/shared/theme/text_styles.dart';
import 'package:provider/src/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final loginProvider = context.watch<LoginProvider>();
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
                 Padding(
                   padding: const EdgeInsets.only(bottom: 5.0),
                   child: CircleAvatar(
                    backgroundImage: NetworkImage(loginProvider.photo),
                    radius: 40,
                   ),
                 ),
                Text(loginProvider.name, style: TextStyles.drawer),
              ],
            ),
            SizedBox(
              height: size.height * 0.05,
              width: size.width * 0.7,
              child: Center(
                child: ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Text("Mental", textAlign: TextAlign.center, style: TextStyles.drawer),
                  ),
                  subtitle: Text(loginProvider.mental.toString(),textAlign: TextAlign.center , style: TextStyles.text,),
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: const Icon(Icons.remove,color: MainColors.green, size: 30,),
                        onTap: () => loginProvider.decrementStat("mental"),
                      ),
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: const Icon(Icons.add, color: MainColors.green, size: 30),
                        onTap: () => loginProvider.incrementStat("mental"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
              width: size.width * 0.7,
              child: Center(
                child: ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Text("Social", textAlign: TextAlign.center, style: TextStyles.drawer),
                  ),
                  subtitle: Text(loginProvider.social.toString(),textAlign: TextAlign.center , style: TextStyles.text,),
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: const Icon(Icons.remove,color: MainColors.green, size: 30,),
                        onTap: () => loginProvider.decrementStat("social"),
                      ),
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: const Icon(Icons.add, color: MainColors.green, size: 30),
                        onTap: () => loginProvider.incrementStat("social"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
              width: size.width * 0.7,
              child: Center(
                child: ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Text("Profissional", textAlign: TextAlign.center, style: TextStyles.drawer),
                  ),
                  subtitle: Text(loginProvider.professional.toString(),textAlign: TextAlign.center , style: TextStyles.text,),
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: const Icon(Icons.remove,color: MainColors.green, size: 30,),
                        onTap: () => loginProvider.decrementStat("professional"),
                      ),
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: const Icon(Icons.add, color: MainColors.green, size: 30),
                        onTap: () => loginProvider.incrementStat("professional"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
              width: size.width * 0.7,
              child: Center(
                child: ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Text("Físico (Corporal)", textAlign: TextAlign.center, style: TextStyles.drawer),
                  ),
                  subtitle: Text(loginProvider.physical.toString(),textAlign: TextAlign.center , style: TextStyles.text,),
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: const Icon(Icons.remove,color: MainColors.green, size: 30,),
                        onTap: () => loginProvider.decrementStat("physical"),
                      ),
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: const Icon(Icons.add, color: MainColors.green, size: 30),
                        onTap: () => loginProvider.incrementStat("physical"),
                      ),
                    ],
                  ),
                ),
              ),
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