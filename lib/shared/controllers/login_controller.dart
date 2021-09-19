import 'package:flutter/cupertino.dart';
import 'package:injector/injector.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginController{

  late final supabase = Injector.appInstance.get<SupabaseClient>();


  Future<void> userAlreadyLogged(BuildContext context) async {

    final profile = supabase.auth.user();

    profile == null
    ?  Navigator.pushReplacementNamed(context, "/login")
    :  Navigator.pushReplacementNamed(context, "/home");
  }

  Future<void> handleLogin() async {
    final response = await supabase.auth.signInWithProvider(
      Provider.google,
    );

    if (response.error? != null) {
      // Error
      print('Error: ${response.error?.message}');
    } 
    else {
      // Success
      print(response.data?)
    }
  }
}