import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:logbook/shared/classes/log.dart';
import 'package:supabase/supabase.dart';

class LogsController{
  Future<List<Log>> getLogs() async{
    late final supabase = Injector.appInstance.get<SupabaseClient>();

    try{
      final response = await  supabase
                          .from("logs")
                          .select()
                          .execute();

      List data = response.data;
      List<Log> logs = data.map((data) => Log.fromJson(data)).toList();
      print(logs);
      return logs;
    }catch(error){
      print(error);
      List<Log> logs = [];
      return logs;
    }
  }
}