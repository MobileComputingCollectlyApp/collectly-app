import 'package:flutter/material.dart';
import 'package:collectly/configs/configs.dart';
import 'package:get/get.dart';

const kOnSurfaceTextColor = Colors.white;
const kCorrectAnswerColor = Color(0xFF3ac3cb);
const kWrongAnswerColor = Color(0xFFf85187);
const kNotAnswerColor = Color(0xFF2a3c65);

// main gradient pattern for light theme
const mainGradientLT = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      kPrimayLightColorLT,
      kPrimayColorLT,
    ]);

// main gradient pattern for Dark theme
const mainGradientDT = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      kPrimayLightColorDT,
      kPrimayColorDT,
    ]);

LinearGradient mainGradient() =>
    UIParameters.isDarkMode() ? mainGradientDT : mainGradientLT;

Color customScaffoldColor(BuildContext context) => UIParameters.isDarkMode()
    ? const Color(0xFF2e3c62)
    : const Color.fromARGB(255, 240, 237, 255);

Color answerBorderColor(BuildContext context) => UIParameters.isDarkMode()
    ? const Color.fromARGB(255, 20, 46, 158)
    : const Color.fromARGB(255, 221, 221, 221);

Color answerSelectedColor(BuildContext context) => Get.isDarkMode
    ? Theme.of(context).cardColor.withOpacity(0.5)
    : Theme.of(context).primaryColor;
