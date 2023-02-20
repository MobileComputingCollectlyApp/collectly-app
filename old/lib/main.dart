import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:collectly_app/bindings/initial_bindings.dart';
import 'package:collectly_app/configs/themes/app_light_theme.dart';
import 'package:collectly_app/configs/themes/app_dark_theme.dart';
import 'package:collectly_app/controllers/theme_controller.dart';
import 'package:collectly_app/routes/app_routes.dart';
import 'package:collectly_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  InitialBindings().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: Get.find<ThemeController>().lightTheme,
      getPages: AppRoutes.routes(),
    );
  }
}
