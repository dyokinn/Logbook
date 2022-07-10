import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

import '../classes/log.dart';

class LogsProvider extends ChangeNotifier{
  List<Log> logs = [];
  late Log activeLog;
  final CollectionReference db = FirebaseFirestore.instance.collection("users");

  void setActiveLog(Log log){
    activeLog = log;
    notifyListeners();
  }

  Future<void> updateLogList(googleId) async {
    QuerySnapshot response = await db.doc(googleId).collection("logs").get();

    logs = response.docs.map(
      (obj) {
        Map parsed = obj.data() as Map<String, dynamic>;
        parsed["id"] = obj.id;
        return Log.fromJson(parsed as Map<String, dynamic>);
        }
    ).toList();
    notifyListeners();
  }

  Future<void> createLog(googleId, Log log) async {
    var response = await db.doc(googleId).collection("logs").add(log.toJson());
    await updateLogList(googleId);
    notifyListeners();
  }

  Future<void> deleteLog(googleId, Log log) async {
    var response = await db.doc(googleId).collection("logs").doc(log.id).delete();
    await updateLogList(googleId);
    notifyListeners();
  }
}