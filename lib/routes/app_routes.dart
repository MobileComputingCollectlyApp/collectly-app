import 'package:collectly/screens/home/shared_project_screen.dart';
import 'package:collectly/screens/play_form/play_form_screen.dart';
import 'package:get/get.dart';
import 'package:collectly/controllers/controllers.dart';
import 'package:collectly/screens/screens.dart';

class AppRoutes {
  static List<GetPage> pages() => [
        GetPage(
          page: () => const SplashScreen(),
          name: SplashScreen.routeName,
        ),
        GetPage(
          page: () => const AppIntroductionScreen(),
          name: AppIntroductionScreen.routeName,
        ),
        GetPage(
            page: () => const HomeScreen(),
            name: HomeScreen.routeName,
            binding: BindingsBuilder(() {
              Get.put(MyDrawerController());
              Get.put(ProjectController());
            })),
        GetPage(
            page: () => const SharedProjectScreen(),
            name: SharedProjectScreen.routeName,
            binding: BindingsBuilder(() {
              Get.put(MyDrawerController());
              Get.put(SharedProjectController());
            })),
        GetPage(
            page: () => const FormScreen(),
            name: FormScreen.routeName,
            binding: BindingsBuilder(() {
              Get.put(FormController());
              Get.put(MyDrawerController());
            })),
        GetPage(
            page: () => const FormDetailsScreen(),
            name: FormDetailsScreen.routeName,
            binding: BindingsBuilder(() {
              Get.put(FormDataController());
              Get.put(MyDrawerController());
            })),
        GetPage(
            page: () => const PlayFormScreen(),
            name: PlayFormScreen.routeName,
            binding: BindingsBuilder(() {
              Get.put<PlayFormController>(PlayFormController());
            })),
        GetPage(page: () => const LoginScreen(), name: LoginScreen.routeName),
      ];
}
