import 'package:easy_separator/easy_separator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:collectly/configs/themes/app_colors.dart';
import 'package:collectly/screens/home/home_screen.dart';
import 'package:collectly/widgets/common/circle_button.dart';

class AppIntroductionScreen extends StatelessWidget {
  const AppIntroductionScreen({Key? key}) : super(key: key);
  static const String routeName = '/introduction';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(gradient: mainGradient()),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.star,
                size: 65,
                color: kOnSurfaceTextColor,
              ),
              SizedBox(
                height: 40,
              ),
              const Text(
                'This is a Research data collection app Researchers can collect various sorts of data from the field. This data can be in text form as well as images, audio recordings (e.g., voice, bird sounds).',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    color: kOnSurfaceTextColor,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 40,
              ),
              CircularButton(
                  onTap: () => Get.offAndToNamed(HomeScreen.routeName),
                  child: const Icon(
                    Icons.arrow_forward,
                    size: 35,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
