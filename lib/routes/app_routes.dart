import 'package:get/get.dart';
import 'package:collectly_app/screens/introduction/introduction.dart';
import 'package:collectly_app/screens/splash/splash_screen.dart';

class AppRoutes {
  static List<GetPage> routes() => [
        GetPage(name: "/", page: () => const SplashScreen()),
        GetPage(
            name: "/introduction", page: () => const AppIntroductionScreen()),
        // GetPage(
        //     name: "/home",
        //     page: () => const HomeScreen(),
        //     binding: BindingsBuilder(() {
        //       Get.put(QuestionPaperController());
        //     }))
      ];
}
