import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injector/injector.dart';
import 'package:logbook/shared/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase/supabase.dart';
import 'package:provider/provider.dart';


class LoginProvider extends ChangeNotifier{
  int id = 0;
  String name = "";
  String email = "";
  String photo = "";

  var mental = 5/10;
  var physical = 5/10;
  var professional = 5/10;
  var social = 5/10;

  // Setters
  void setUserInfoFromMap(Map<String, dynamic> userInfo){
    id = userInfo["id"];
    name = userInfo["name"];
    email = userInfo["email"];
    photo = userInfo["photo"];

    notifyListeners();
  }

  void setUserStatsFromMap(Map<String, dynamic> userStats){
    mental = userStats["mental"];
    physical = userStats["physical"];
    professional = userStats["professional"];
    social = userStats["social"];

    notifyListeners();
  }

  // Checa se o usuário já logou anteriormente
  Future<void> userAlreadyLogged(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey("userInfo") && prefs.containsKey("userStats")){
      final userProvider = context.read<LoginProvider>();
      userProvider.setUserInfoFromMap(jsonDecode(await prefs.getString("userInfo") as String));
      userProvider.setUserStatsFromMap(jsonDecode(await prefs.getString("userStats") as String));
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
      var googleId = await googleUser!.authentication.then((value) => value.idToken);

      // Verifica se o usuário autenticado já existe no banco
      try{
        final accountFromDb = await Api.dio.get("/users/login", 
          queryParameters: {
          "key": googleId
          }
        );

        final prefs = await SharedPreferences.getInstance();
        final userProvider = context.read<LoginProvider>();

        Map<String, dynamic> userInfo = {
          "id": accountFromDb.data["id"],
          "name": googleUser.displayName,
          "email": googleUser.email,
          "photo": googleUser.photoUrl
        };

        Map<String, double> userStats = {
          "mental": 5/10,
          "physical": 5/10,
          "professional": 5/10,
          "social": 5/10
        };

        userProvider.setUserInfoFromMap(userInfo);
        userProvider.setUserStatsFromMap(userStats);

        // Salva nas Shared Preferences
        await prefs.setString("userInfo", jsonEncode(userInfo));
        await prefs.setString("userStats", jsonEncode(userStats));

        Navigator.pushReplacementNamed(context, "/home");
      
      }
      
      // Se não existir no banco
      catch(e){
        print("n existe no banco");
        try{
          final created = await Api.dio.post("/users/create",
            data: {
              "googleId": googleId
            }
          );
          print("chegou");

          // Salva no Provider
          final prefs = await SharedPreferences.getInstance();
          final userProvider = context.read<LoginProvider>();

          Map<String, dynamic> userInfo = {
            "id": created.data["id"],
            "name": googleUser.displayName,
            "email": googleUser.email,
            "photo": googleUser.photoUrl
          };

          Map<String, double> userStats = {
            "mental": 5/10,
            "physical": 5/10,
            "professional": 5/10,
            "social": 5/10
          };

          userProvider.setUserInfoFromMap(userInfo);
          userProvider.setUserStatsFromMap(userStats);

          // Salva nas Shared Preferences
          await prefs.setString("userInfo", jsonEncode(userInfo));
          await prefs.setString("userStats", jsonEncode(userStats));
          Navigator.pushReplacementNamed(context, "/home");

        }
        catch (error) {
          print(error);
        }

      }}
      catch (error) {
          print(error);
        }}  
  
  Future<void> handleLogout(BuildContext context) async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: [
          'email'
        ],
      );
    final prefs = await SharedPreferences.getInstance();

    await _googleSignIn.signOut();
    await prefs.clear();
    Navigator.pushReplacementNamed(context, "/login");

  }
  }