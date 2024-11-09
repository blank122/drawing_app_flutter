import 'package:file_upload/services/theme_service.dart';
import 'package:file_upload/views/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThemeService().loadPreferences();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final themeService = ThemeService();

  // This widget is the root of your application.
  @override
  //  textTheme: GoogleFonts.interTextTheme(
  //             Theme.of(context).textTheme,
  //           ),
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          themeMode: themeService.themeMode,
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: themeService.appBarColor,
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: themeService.bottomNavBarColor,
            ),
            drawerTheme: DrawerThemeData(
              backgroundColor: themeService.drawerColor,
            ),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: themeService.appBarColor,
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: themeService.bottomNavBarColor,
            ),
            drawerTheme: DrawerThemeData(
              backgroundColor: themeService.drawerColor,
            ),
            textTheme: GoogleFonts.interTextTheme(
              Theme.of(context).textTheme,
            ),
          ),
          home: const Home(),
        );
      },
    );
  }
}
