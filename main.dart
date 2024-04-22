import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // 13: Create insatance of themeData
  late ThemeData _appTheme = lightTheme;
  // 11: Create lightTheme using ThemeData class
  final lightTheme= ThemeData.light();
  // 12: Create darkTheme using ThemeData class
  final darkTheme= ThemeData.dark();
  // 15: Create a method to load the theme
  void loadTheme() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDark = prefs.getBool("isDark??" )?? false;
    setState(() {
      _appTheme = isDark ? darkTheme : lightTheme;
    });
  }
  // 17: Create a method to change the Theme
  void changeTheme(bool isDark) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isDark",isDark);
    setState(() {
      _appTheme = isDark ? darkTheme : lightTheme;
    });
  }

  // 16: Call the initState method
  @override
  void initState() {
    // : implement initState
    loadTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // 14: Chanage theme properity with the instance
      theme: _appTheme,
      // 22: modify the Home Screen
      home: HomeScreen(onThemeChange: changeTheme,),
    );
  }
}
