import 'package:file_upload/services/color_picker.dart';
import 'package:file_upload/services/theme_service.dart';
import 'package:flutter/material.dart';

class ThemeSettings extends StatelessWidget {
  final themeService = ThemeService();

  ThemeSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Theme Settings')),
      body: Column(
        children: [
          // SwitchListTile(
          //   title: Text("Dark Mode"),
          //   value: themeService.themeMode == ThemeMode.dark,
          //   onChanged: (isDark) {
          //     themeService
          //         .setThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
          //     (context as Element).reassemble(); // Refresh the widget
          //   },
          // ),
          ListTile(
            title: const Text("App Bar Color"),
            trailing: ColorThemePicker(
              currentColor: themeService.appBarColor,
              onColorSelected: (color) {
                themeService.setAppBarColor(color);
                // ignore: invalid_use_of_protected_member
                (context as Element).reassemble(); // Refresh the widget
              },
            ),
          ),
          ListTile(
            title: const Text("Bottom Navigation Bar Color"),
            trailing: ColorThemePicker(
              currentColor: themeService.bottomNavBarColor,
              onColorSelected: (color) {
                themeService.setBottomNavBarColor(color);
                (context as Element).reassemble(); // Refresh the widget
              },
            ),
          ),
          ListTile(
            title: const Text("Drawer Color"),
            trailing: ColorThemePicker(
              currentColor: themeService.drawerColor,
              onColorSelected: (color) {
                themeService.setDrawerColor(color);
                (context as Element).reassemble(); // Refresh the widget
              },
            ),
          ),
        ],
      ),
    );
  }
}
