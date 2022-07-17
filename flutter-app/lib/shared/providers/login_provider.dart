import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logbook/shared/providers/goals_provider.dart';
import 'package:logbook/shared/providers/logs_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase/supabase.dart';
import 'package:provider/provider.dart';


class LoginProvider extends ChangeNotifier{
  String googleId = "";
  String name = "";
  String email = "";
  String photo = "";

  var mental = 5;
  var physical = 5;
  var professional = 5;
  var social = 5;

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;


  // Setters

  void incrementStat(String statName) {
    switch (statName) {
      case "mental":
        if(mental < 10){
          mental += 1;
        }
        break;
      case "social":
        if(social < 10){
          social += 1;
        }
      break;
      case "professional":
      if(professional < 10){
        professional += 1;
      }
      break;
      case "physical":
      if(physical < 10){
        physical += 1;
      }
      break;
      default:
    }
    notifyListeners();
  }

  void decrementStat(String statName) {
    switch (statName) {
      case "mental":
        if(mental > 0){
          mental -= 1;
        }
        break;
      case "social":
        if(social > 0){
          social -= 1;
        }
      break;
      case "professional":
      if(professional > 0){
        professional -= 1;
      }
      break;
      case "physical":
      if(physical > 0){
        physical -= 1;
      }
      break;
      default:
    }
    notifyListeners();
  }

  void setUserInfoFromMap(Map<String, dynamic> userInfo){
    googleId = userInfo["id"];
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
      final logsProvider = context.read<LogsProvider>();
      final goalsProvider = context.read<GoalsProvider>();

      userProvider.setUserInfoFromMap(jsonDecode(await prefs.getString("userInfo") as String));
      userProvider.setUserStatsFromMap(jsonDecode(await prefs.getString("userStats") as String));

      // Seta as logs e goals iniciais daquele usuário
      await logsProvider.updateLogList(googleId);
      await goalsProvider.updateGoalList(googleId);


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
      GoogleSignInAuthentication googleSignInAuthentication = await googleUser!.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      UserCredential fullCredentials = await firebaseAuth.signInWithCredential(credential);
      print("chegou");
      var googleId = fullCredentials.user!.uid;

      final prefs = await SharedPreferences.getInstance();
      final userProvider = context.read<LoginProvider>();
      final logsProvider = context.read<LogsProvider>();
      final goalsProvider = context.read<GoalsProvider>();


      Map<String, dynamic> userInfo = {
        "id": googleId,
        "name": googleUser.displayName,
        "email": googleUser.email,
        "photo": googleUser.photoUrl
      };

      Map<String, int> userStats = {
        "mental": 5,
        "physical": 5,
        "professional": 5,
        "social": 5
      };

      userProvider.setUserInfoFromMap(userInfo);
      userProvider.setUserStatsFromMap(userStats);

      // Salva nas Shared Preferences
      await prefs.setString("userInfo", jsonEncode(userInfo));
      await prefs.setString("userStats", jsonEncode(userStats));

      // Seta as logs e goals iniciais daquele usuário
      await logsProvider.updateLogList(googleId);
      await goalsProvider.updateGoalList(googleId);

      Navigator.pushReplacementNamed(context, "/home");
      
      } catch(e){
        print(e);
      }
      
      // Se não existir no banco
      }  
  
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