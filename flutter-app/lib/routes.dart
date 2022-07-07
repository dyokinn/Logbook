import 'package:flutter/material.dart';
import 'package:logbook/modules/screens/create_log.dart';
import 'package:logbook/modules/screens/home_page.dart';
import 'package:logbook/modules/screens/login_page.dart';
import 'package:logbook/modules/screens/splash_page.dart';

Map<String, WidgetBuilder> routes = {
    "/splash": (BuildContext context) => SplashPage(),
    "/home": (BuildContext context) => HomePage(),
    "/login": (BuildContext context) => LoginPage(),
    "/create-log": (BuildContext context) => CreateLog(),

};