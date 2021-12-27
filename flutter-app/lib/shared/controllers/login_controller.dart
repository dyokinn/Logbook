import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injector/injector.dart';
import 'package:logbook/shared/providers/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase/supabase.dart';
import 'package:provider/provider.dart';


class LoginController{

  late final supabase = Injector.appInstance.get<SupabaseClient>();

  // Checa se o usuário já logou anteriormente
  Future<void> userAlreadyLogged(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey("userInfo") && prefs.containsKey("userStats")){
      final userProvider = context.read<userState>();
      userProvider.setUserInfo(jsonDecode(await prefs.getString("userInfo") as String));
      userProvider.setUserStats(jsonDecode(await prefs.getString("userStats") as String));
      Navigator.pushReplacementNamed(context, "/home");
    }

    else{
      Navigator.pushReplacementNamed(context, "/login");
    }
  }

  // Gerencia o login e salva as informações do usuário nas SP
  Future<void> handleLogin(BuildContext context) async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: [
          'email'
        ],
      );
    
    try {
      // Tenta logar com o Google
      final googleUser = await _googleSignIn.signIn();

      // Verifica se o usuário autenticado já existe no banco
      final accountFromDb = await supabase
                        .from("users")
                        .select()
                        .eq("email", googleUser?.email.toString())
                        .execute();
      print(googleUser?.email.toString());
      print(accountFromDb.data);

      // Se não existir no banco
      if (accountFromDb.data.length == 0){

        try{
          final created = await supabase
                            .from("users")
                            .insert({
                              "email": googleUser?.email,
                              "name": googleUser?.displayName
                            })
                            .execute();
          // Salva no Provider
          final prefs = await SharedPreferences.getInstance();
          final userProvider = context.read<userState>();

          Map<String, dynamic> userInfo = {
            "id": created.data[0]["id"],
            "name": created.data[0]["name"],
            "email": created.data[0]["email"],
            "photo": googleUser?.photoUrl
          };

          Map<String, double> userStats = {
            "mental": 5/10,
            "physical": 5/10,
            "professional": 5/10,
            "social": 5/10
          };

          userProvider.setUserInfo(userInfo);
          userProvider.setUserStats(userStats);

          // Salva nas Shared Preferences
          await prefs.setString("userInfo", jsonEncode(userInfo));
          await prefs.setString("userStats", jsonEncode(userStats));

          Navigator.pushReplacementNamed(context, "/home");

        }catch(error){
          print("deu pau e não existe");
        }
      }
      // Se já existir no banco
      else{
        try{
          // Salva no Provider
          final prefs = await SharedPreferences.getInstance();
          final userProvider = context.read<userState>();

          Map<String, dynamic> userInfo = {
            "id": accountFromDb.data[0]["id"],
            "name": accountFromDb.data[0]["name"],
            "email": accountFromDb.data[0]["email"],
            "photo": googleUser?.photoUrl
          };

          Map<String, double> userStats = {
            "mental": 5/10,
            "physical": 5/10,
            "professional": 5/10,
            "social": 5/10
          };

          userProvider.setUserInfo(userInfo);
          userProvider.setUserStats(userStats);

          // Salva nas Shared Preferences
          await prefs.setString("userInfo", jsonEncode(userInfo));
          await prefs.setString("userStats", jsonEncode(userStats));

          Navigator.pushReplacementNamed(context, "/home");

        }catch(error){
          print("deu pau e já existe");
          print(error);
        }
      }
    } 
    
    catch (error) {
      print(error);
    }
  }

}
