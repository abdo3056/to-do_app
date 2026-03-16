import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/sharedPref.dart';

class ThemeCubit extends Cubit<ThemeMode>{
  ThemeCubit() : super (ThemeMode.system) {loadTheme();}

  loadTheme() {
    String? theme = CacheHelper.getData(key: 'themeMode');
    if (theme == 'light') {emit(ThemeMode.light);}

    else if (theme == 'dark') {emit(ThemeMode.dark);}

    else {emit(ThemeMode.system);}
  }

  toggleTheme(bool isDark) {
    ThemeMode newTheme = isDark? ThemeMode.dark : ThemeMode.light;
    CacheHelper.setData(key: 'themeMode', value: isDark ? 'dark' : 'light');
    emit(newTheme);
  }


}