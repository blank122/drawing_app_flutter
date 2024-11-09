import 'package:file_upload/services/color_picker.dart';
import 'package:file_upload/services/theme_service.dart';
import 'package:flutter/material.dart';

class ThemeSettings extends StatefulWidget {
  final VoidCallback onThemeUpdated;

  const ThemeSettings({super.key, required this.onThemeUpdated});

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
                  themeService.setAppBarColor(color); // Save change immediately
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
                  themeService
                      .setBottomNavBarColor(color); // Save change immediately
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
                  themeService.setDrawerColor(color); // Save change immediately
                });
              },
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                widget.onThemeUpdated(); // Notify HomeScreen of theme update
                Navigator.pop(context); // Go back to HomeScreen
              },
              child: const Text("Save"),
            ),
          ),
        ],
      ),
    );
  }
}
