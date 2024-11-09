import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  static final ThemeService _instance = ThemeService._internal();
  factory ThemeService() => _instance;
  ThemeService._internal();

  Color appBarColor = Colors.blue;
  Color bottomNavBarColor = Colors.blue;
  Color drawerColor = Colors.blue;

  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    appBarColor = Color(prefs.getInt('appBarColor') ?? Colors.blue.value);
    bottomNavBarColor =
        Color(prefs.getInt('bottomNavBarColor') ?? Colors.blue.value);
    drawerColor = Color(prefs.getInt('drawerColor') ?? Colors.blue.value);
  }

  Future<void> savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('appBarColor', appBarColor.value);
    await prefs.setInt('bottomNavBarColor', bottomNavBarColor.value);
    await prefs.setInt('drawerColor', drawerColor.value);
  }

  void setAppBarColor(Color color) {
    appBarColor = color;
    savePreferences(); // Save immediately
  }

  void setBottomNavBarColor(Color color) {
    bottomNavBarColor = color;
    savePreferences(); // Save immediately
  }

  void setDrawerColor(Color color) {
    drawerColor = color;
    savePreferences(); // Save immediately
  }
}
