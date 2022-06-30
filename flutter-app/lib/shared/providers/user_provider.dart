import 'package:flutter/material.dart';

class userState extends ChangeNotifier{
   Map<String, dynamic> _userInfo = {
    "id": 0,
    "name": "",
    "email": "",
    "photo": ""
  };

  Map<String, dynamic> _userStats = {
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
    notifyListeners();
  }

  void setUserInfoField(String field, dynamic value){
    _userInfo[field] = value;
    notifyListeners();
  }

  void setUserStats(Map<String, dynamic> userStats){
    _userStats= userStats;
    notifyListeners();
  }
}