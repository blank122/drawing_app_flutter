import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  static final ThemeService _instance = ThemeService._internal();
  factory ThemeService() => _instance;
  ThemeService._internal();

  ThemeMode themeMode = ThemeMode.system;
  Color appBarColor = Colors.blue;
  Color bottomNavBarColor = Colors.blue;
  Color drawerColor = Colors.blue;

  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    themeMode = ThemeMode.values[prefs.getInt('themeMode') ?? 0];
    appBarColor = Color(prefs.getInt('appBarColor') ?? Colors.blue.value);
    bottomNavBarColor =
        Color(prefs.getInt('bottomNavBarColor') ?? Colors.blue.value);
    drawerColor = Color(prefs.getInt('drawerColor') ?? Colors.blue.value);
  }

  Future<void> savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('themeMode', themeMode.index);
    prefs.setInt('appBarColor', appBarColor.value);
    prefs.setInt('bottomNavBarColor', bottomNavBarColor.value);
    prefs.setInt('drawerColor', drawerColor.value);
  }

  void setThemeMode(ThemeMode mode) {
    themeMode = mode;
    savePreferences();
  }

  void setAppBarColor(Color color) {
    appBarColor = color;
    savePreferences();
  }

  void setBottomNavBarColor(Color color) {
    bottomNavBarColor = color;
    savePreferences();
  }

  void setDrawerColor(Color color) {
    drawerColor = color;
    savePreferences();
  }
}
