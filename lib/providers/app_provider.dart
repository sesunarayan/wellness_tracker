import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/activity.dart';

class AppProvider extends ChangeNotifier {
  final SharedPreferences prefs;
  bool isOnboarded = false;
  String name = '';
  int age = 0;
  String gender = '';
  bool isDarkMode = false;


  int waterGlasses = 0;
  int steps = 0;
  double sleepHours = 0.0;

  List<Activity> activities = [];

  AppProvider(this.prefs) {
    _loadAll();
  }

  void _loadAll() {
    isOnboarded = prefs.getBool('onboarded') ?? false;
    name = prefs.getString('name') ?? '';
    age = prefs.getInt('age') ?? 0;
    gender = prefs.getString('gender') ?? '';
    isDarkMode = prefs.getBool('darkMode') ?? false;

    waterGlasses = prefs.getInt('water') ?? 0;
    steps = prefs.getInt('steps') ?? 0;
    sleepHours = prefs.getDouble('sleep') ?? 0.0;

    final raw = prefs.getString('activities') ?? '[]';
    final list = jsonDecode(raw) as List<dynamic>;
    activities = list.map((e) => Activity.fromJson(Map<String, dynamic>.from(e))).toList();
    notifyListeners();
  }

  Future<void> onComplete(String name, int age, String gender) async {
    this.name = name;
    this.age = age;
    this.gender = gender;
    isOnboarded = true;
    await prefs.setBool('onboarded', true);
    await prefs.setString('name', name);
    await prefs.setInt('age', age);
    await prefs.setString('gender', gender);
    notifyListeners();
  }

  Future<void> toggleDarkMode() async {
    isDarkMode = !isDarkMode;
    await prefs.setBool('darkMode', isDarkMode);
    notifyListeners();
  }

  Future<void> updateToday({int? water, int? steps, double? sleep}) async {
    if (water != null) {
      waterGlasses = water;
      await prefs.setInt('water', waterGlasses);
    }
    if (steps != null) {
      this.steps = steps;
      await prefs.setInt('steps', this.steps);
    }
    if (sleep != null) {
      sleepHours = sleep;
      await prefs.setDouble('sleep', sleepHours);
    }
    notifyListeners();
  }

  Future<void> addActivity(Activity a) async {
    activities.insert(0, a);
    await prefs.setString(
      'activities',
      jsonEncode(activities.map((e) => e.toJson()).toList()),
    );
    notifyListeners();
  }

  Future<void> removeActivity(Activity a) async {
    activities.removeWhere((x) => x.id == a.id);
    await prefs.setString(
      'activities',
      jsonEncode(activities.map((e) => e.toJson()).toList()),
    );
    notifyListeners();
  }
}
