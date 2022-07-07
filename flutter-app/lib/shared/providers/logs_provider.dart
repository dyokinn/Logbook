import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

import '../classes/log.dart';

class LogsProvider extends ChangeNotifier{
  List<Log> logs = [];

  final CollectionReference db = FirebaseFirestore.instance.collection("users");

  Future<void> updateLogList(googleId) async {
    QuerySnapshot response = await db.doc(googleId).collection("logs").get();

    logs = response.docs.map((obj) => Log.fromJson(obj.data() as Map<String, dynamic>)).toList();
    notifyListeners();
  }

  Future<void> createLog(googleId, Log log) async {
    var response = await db.doc(googleId).collection("logs").add(log.toJson());
    await updateLogList(googleId);
    notifyListeners();
  }
}