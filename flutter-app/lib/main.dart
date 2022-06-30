import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:logbook/routes.dart';
import 'package:logbook/shared/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:logbook/modules/screens/splash_page.dart';
import 'package:logbook/shared/theme/main_colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://thvrccvjpjymkdogdoyg.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTYzMTk3NTcxNCwiZXhwIjoxOTQ3NTUxNzE0fQ.VpWXp4kaShsjmhVTCT7SQyLgXDmy99b6W4VPc5K1eCY',
  );
  final supabase = SupabaseClient('https://thvrccvjpjymkdogdoyg.supabase.co', "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTYzMTk3NTcxNCwiZXhwIjoxOTQ3NTUxNzE0fQ.VpWXp4kaShsjmhVTCT7SQyLgXDmy99b6W4VPc5K1eCY");
  final firebase = Firebase.initializeApp();

  Injector.appInstance.registerSingleton<SupabaseClient>(() => supabase);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: userState())
      ],
      child: MaterialApp(
        title: 'Logbook',
        theme: ThemeData(
          primaryColor: MainColors.black,
        ),
        home: SplashPage(),
        routes: routes,
      ),
    );
  }
}

