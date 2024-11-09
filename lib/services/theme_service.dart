import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  static final ThemeService _instance = ThemeService._internal();
  factory ThemeService() => _instance;
  ThemeService._internal();

  // Add a callback to notify listeners
  VoidCallback? _listener;

  ThemeMode themeMode = ThemeMode.system;
  Color appBarColor = Colors.white;
  Color bottomNavBarColor = Colors.white;
  Color drawerColor = Colors.white;
  Color appBodyColor = Colors.white;

  void setListener(VoidCallback listener) {
    _listener = listener;
  }

  void notify() {
    _listener?.call();
  }

  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    themeMode = ThemeMode.values[prefs.getInt('themeMode') ?? 0];
    appBarColor = Color(prefs.getInt('appBarColor') ?? Colors.white.value);
    bottomNavBarColor =
        Color(prefs.getInt('bottomNavBarColor') ?? Colors.white.value);
    drawerColor = Color(prefs.getInt('drawerColor') ?? Colors.white.value);
    appBodyColor = Color(prefs.getInt('appBodyColor') ?? Colors.white.value);
  }

  Future<void> savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('themeMode', themeMode.index);
    prefs.setInt('appBarColor', appBarColor.value);
    prefs.setInt('bottomNavBarColor', bottomNavBarColor.value);
    prefs.setInt('drawerColor', drawerColor.value);
    prefs.setInt('appBodyColor', appBodyColor.value);
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
