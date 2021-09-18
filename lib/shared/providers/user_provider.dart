import 'dart:ffi';

import 'package:flutter/cupertino.dart';

class userState extends ChangeNotifier{
   Map<String, dynamic> _userInfo = {
    "id": 0,
    "email": "",
    "photo": ""
  };

  Map<String, double> _userStats = {
    "mental": 5/10,
    "physical": 5/10,
    "professional": 5/10,
    "social": 5/10
  };

  // Getters
  Map get userInfo => _userInfo;

  Map get userStats => _userStats;

  // Setters
  void setUserInfo(Map<String, dynamic> userInfo){
    _userInfo = userInfo;
  }

  void setUserStats(Map<String, double> userStats){
    _userStats= userStats;
  }
}