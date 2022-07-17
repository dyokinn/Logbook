import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:logbook/routes.dart';
import 'package:logbook/shared/providers/goals_provider.dart';
import 'package:logbook/shared/providers/login_provider.dart';
import 'package:logbook/shared/providers/logs_provider.dart';
import 'package:provider/provider.dart';
import 'package:supabase/supabase.dart';
import 'package:logbook/modules/screens/splash_page.dart';
import 'package:logbook/shared/theme/main_colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: LoginProvider()),
        ChangeNotifierProvider.value(value: LogsProvider()),
        ChangeNotifierProvider.value(value: GoalsProvider()),
      ],
      child: MaterialApp(
        title: 'Logbook',
        theme: ThemeData(
          primaryColor: MainColors.black,
        ),
        home: SplashPage(),
        debugShowCheckedModeBanner: false,
        routes: routes,
      ),
    );
  }
}


