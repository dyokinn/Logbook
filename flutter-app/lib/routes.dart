import 'package:flutter/material.dart';
import 'package:logbook/modules/screens/create_goal.dart';
import 'package:logbook/modules/screens/create_log.dart';
import 'package:logbook/modules/screens/goal_view.dart';
import 'package:logbook/modules/screens/home_page.dart';
import 'package:logbook/modules/screens/log_view.dart';
import 'package:logbook/modules/screens/login_page.dart';
import 'package:logbook/modules/screens/splash_page.dart';

Map<String, WidgetBuilder> routes = {
  "/splash": (BuildContext context) => SplashPage(),
  "/home": (BuildContext context) => HomePage(),
  "/login": (BuildContext context) => LoginPage(),
  "/create-log": (BuildContext context) => CreateLog(),
  "/create-goal": (BuildContext context) => CreateGoal(),
  "/log-view": (BuildContext context) => LogView(),
  "/goal-view": (BuildContext context) => GoalView(),

};