import 'package:file_upload/services/color_picker.dart';
import 'package:file_upload/services/theme_service.dart';
import 'package:flutter/material.dart';

class ThemeSettings extends StatefulWidget {
  const ThemeSettings({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ThemeSettingsState createState() => _ThemeSettingsState();
}

class _ThemeSettingsState extends State<ThemeSettings> {
  final themeService = ThemeService();

  late Color selectedAppBarColor;
  late Color selectedBottomNavBarColor;
  late Color selectedDrawerColor;

  @override
  void initState() {
    super.initState();
    // Initialize with current theme colors
    selectedAppBarColor = themeService.appBarColor;
    selectedBottomNavBarColor = themeService.bottomNavBarColor;
    selectedDrawerColor = themeService.drawerColor;
  }

  void saveThemeSettings() {
    themeService.setAppBarColor(selectedAppBarColor);
    themeService.setBottomNavBarColor(selectedBottomNavBarColor);
    themeService.setDrawerColor(selectedDrawerColor);
    themeService.savePreferences(); // Save all changes at once
    Navigator.pop(context); // Navigate back to HomeScreen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Theme Settings')),
      body: Column(
        children: [
          ListTile(
            title: const Text("App Bar Color"),
            trailing: ColorThemePicker(
              currentColor: selectedAppBarColor,
              onColorSelected: (color) {
                setState(() {
                  selectedAppBarColor = color;
                });
              },
            ),
          ),
          ListTile(
            title: const Text("Bottom Navigation Bar Color"),
            trailing: ColorThemePicker(
              currentColor: selectedBottomNavBarColor,
              onColorSelected: (color) {
                setState(() {
                  selectedBottomNavBarColor = color;
                });
              },
            ),
          ),
          ListTile(
            title: const Text("Drawer Color"),
            trailing: ColorThemePicker(
              currentColor: selectedDrawerColor,
              onColorSelected: (color) {
                setState(() {
                  selectedDrawerColor = color;
                });
              },
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: saveThemeSettings,
              child: const Text("Save"),
            ),
          ),
        ],
      ),
    );
  }
}
