// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

import '../../shared/theme/main_colors.dart';

class AppBarWithBack extends StatelessWidget with PreferredSizeWidget{
  const AppBarWithBack({ Key? key, required this.pageToGo }) : super(key: key);

  final pageToGo;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
          title: const Text("Logbook"),
          leading: GestureDetector(child: const Icon(Icons.arrow_back, color: MainColors.green,), onTap: () =>  Navigator.push(context, PageRouteBuilder(
          pageBuilder: (context, __, ___) => pageToGo, 
          transitionDuration: const Duration(milliseconds: 750),
        )),),
          backgroundColor: MainColors.black,
          shadowColor: MainColors.blue,
          elevation: 2.0,
        );
  }
}