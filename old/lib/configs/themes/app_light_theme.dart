import 'package:flutter/material.dart';
import 'package:collectly_app/configs/themes/sub_theme_data_mixin.dart';

const Color primaryLightColorLight = Color(0xFFc471ed);
const Color primaryColorLight = Color(0xFFf64f59);
const Color mainTextColorLight = Color.fromARGB(255, 40, 40, 40);

class LightTheme with SubThemeData {
  ThemeData buildLightTheme() {
    final ThemeData systemLightTheme = ThemeData.light();
    return systemLightTheme.copyWith(
      iconTheme: getIconTheme(),
      textTheme: getTextThemes().apply(
        bodyColor: mainTextColorLight,
        displayColor: mainTextColorLight,
      ),
    );
  }
}
