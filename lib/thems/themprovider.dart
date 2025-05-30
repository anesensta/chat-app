import 'package:chatapp/thems/darkmode.dart';
import 'package:chatapp/thems/lightmode.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Themprovider extends ChangeNotifier {
  ThemeData _themedata = lightmode;
  bool get isdarkmode => _themedata == darkmode;
  ThemeData get Themedata => _themedata;

  Themprovider() {
    // Load the theme mode when the provider is initialized
    _loadThemePreference();
  }

  set Themedata(ThemeData newThemedata) {
    _themedata = newThemedata;
    notifyListeners();
    _saveThemePreference(); // Save the theme preference
  }

  void swithbutton() {
    if (_themedata == lightmode) {
      Themedata = darkmode;
    } else {
      Themedata = lightmode;
    }
  }

  // Save the user's theme preference to SharedPreferences
  Future<void> _saveThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isdarkmode', isdarkmode);
  }

  // Load the user's theme preference from SharedPreferences
  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    final bool? isDarkMode = prefs.getBool('isdarkmode');

    if (isDarkMode != null) {
      _themedata = isDarkMode ? darkmode : lightmode;
      notifyListeners();
    }
  }
}
