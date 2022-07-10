import 'package:flutter/material.dart';

import '../../shared/theme/main_colors.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget{
  const CustomAppBar({ Key? key }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text("Logbook"),
        backgroundColor: MainColors.black,
        iconTheme: IconThemeData(color: MainColors.green),
        shadowColor: MainColors.blue,
        elevation: 2.0,
      );
  }
}