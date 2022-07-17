import 'package:flutter/material.dart';

import '../../shared/theme/main_colors.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget{
  const CustomAppBar({ Key? key }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: const Text("Logbook"),
        backgroundColor: MainColors.black,
        iconTheme: const IconThemeData(color: MainColors.green),
        shadowColor: MainColors.blue,
        elevation: 2.0,
      );
  }
}