import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:logbook/shared/classes/goal.dart';
import 'package:logbook/shared/classes/goal_step.dart';


class GoalsProvider extends ChangeNotifier{
  List<Goal?> allGoals = [];
  List<Goal?> filteredGoals = [];

  bool includeCompletedGoals = false;
  late Goal activeGoal;
  final CollectionReference db = FirebaseFirestore.instance.collection("users");

  void setIncludeComplete(bool value){
    includeCompletedGoals = value;
    notifyListeners();
  }

  void setActiveGoal(Goal goal){
    activeGoal = goal;
    notifyListeners();
  }

  addGoalStep(googleId, GoalStep step) async {
    activeGoal.steps.add(step);
    activeGoal.isComplete = false;
    activeGoal.completed_at = null;
    await updateGoal(googleId, activeGoal);
    notifyListeners();
  }

  removeGoalStep(googleId, GoalStep step) async {
    activeGoal.steps.remove(step);

    if(activeGoal.steps.every((element) => element.isComplete)){
      activeGoal.isComplete = true;
      activeGoal.completed_at = DateTime.now();
    } else{
      activeGoal.isComplete = false;
      activeGoal.completed_at = null;
    }

    await updateGoal(googleId, activeGoal);
    notifyListeners();
  }

  void toggleGoalStep(googleId, int index, bool previousState) async {
    if (previousState == false) {
      activeGoal.steps[index].isComplete = true;
      activeGoal.steps[index].completedAt = DateTime.now();
    } else {
      activeGoal.steps[index].isComplete = false;
      activeGoal.steps[index].completedAt = null;
    }

    if(activeGoal.steps.every((element) => element.isComplete)){
      activeGoal.isComplete = true;
      activeGoal.completed_at = DateTime.now();
    } else{
      activeGoal.isComplete = false;
      activeGoal.completed_at = null;
    }

    await updateGoal(googleId, activeGoal);
    notifyListeners();
  }

  void toggleActiveGoalStatus(googleId) async {
    if(activeGoal.isComplete){
      activeGoal.isComplete = false;
      activeGoal.completed_at = null;
    } else {
      activeGoal.isComplete = true;
      activeGoal.completed_at = DateTime.now();
    }

    await updateGoal(googleId, activeGoal);
    notifyListeners();
  }

  Future<void> updateGoalList(googleId) async {
    QuerySnapshot response = await db.doc(googleId).collection("goals").get();

    allGoals = response.docs.map(
      (obj) {
        Map parsed = obj.data() as Map<String, dynamic>;
        parsed["id"] = obj.id;
        
        return Goal.fromJson(parsed as Map<String, dynamic>);
      }
    ).toList();

    filteredGoals = allGoals;

    if (!includeCompletedGoals){
      filteredGoals = allGoals.where((goal) => goal?.isComplete == false).toList();
    }

    notifyListeners();
  }

  Future<void> createGoal(googleId, Goal goal) async {
    var response = await db.doc(googleId).collection("goals").add(goal.toJson());
    await updateGoalList(googleId);
    notifyListeners();
  }

  Future<void> updateGoal(googleId, Goal goal) async {
    await db.doc(googleId).collection("goals").doc(goal.id).update(goal.toJson());
    await updateGoalList(googleId);
    notifyListeners();
  }

  Future<void> deleteGoal(googleId, Goal goal) async {
    var response = await db.doc(googleId).collection("goals").doc(goal.id).delete();
    await updateGoalList(googleId);
    notifyListeners();
  }
}