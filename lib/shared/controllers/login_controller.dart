import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injector/injector.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginController{

  late final supabase = Injector.appInstance.get<SupabaseClient>();


  void userAlreadyLogged(BuildContext context) async {
    //Navigator.pushReplacementNamed(context, "/login");
  }

  Future<void> handleLogin() async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: [
          'email'
        ],
      );
    
    try {
      final user = await _googleSignIn.signIn();

      final response = await supabase
                        .from("users")
                        .select()
                        .execute();
    
      print("ABAIXO");
      print(response.data);
    
    } 
    
    catch (error) {
      print(error);
    }
  }

}
