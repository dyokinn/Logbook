import 'package:flutter/material.dart';

import '../../shared/theme/main_colors.dart';

class AppBarWithBack extends StatelessWidget with PreferredSizeWidget{
  const AppBarWithBack({ Key? key, required this.pageToGo }) : super(key: key);

  final pageToGo;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
          title: Text("Logbook"),
          leading: GestureDetector(child: Icon(Icons.arrow_back, color: MainColors.green,), onTap: () =>  Navigator.push(context, PageRouteBuilder(
          pageBuilder: (context, __, ___) => pageToGo, 
          transitionDuration: Duration(milliseconds: 750),
        )),),
          backgroundColor: MainColors.black,
          shadowColor: MainColors.blue,
          elevation: 2.0,
        );
  }
}