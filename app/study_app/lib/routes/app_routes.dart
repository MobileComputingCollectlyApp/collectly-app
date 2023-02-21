import 'package:collectly/controllers/project_form/form_controller.dart';
import 'package:collectly/controllers/project_form/form_data_controller.dart';
import 'package:collectly/controllers/project_form/project_controller.dart';
import 'package:collectly/controllers/project_form/shared_project_controller.dart';
import 'package:collectly/screens/home/shared_project_screen.dart';
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
              Get.put(QuizPaperController());
              Get.put(MyDrawerController());
              Get.put(ProjectController());
            })),
        GetPage(
            page: () => const SharedProjectScreen(),
            name: SharedProjectScreen.routeName,
            binding: BindingsBuilder(() {
              Get.put(QuizPaperController());
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
        GetPage(page: () => const LoginScreen(), name: LoginScreen.routeName),
        GetPage(
            page: () => LeaderBoardScreen(),
            name: LeaderBoardScreen.routeName,
            binding: BindingsBuilder(() {
              Get.put(LeaderBoardController());
            })),
        GetPage(
            page: () => const QuizeScreen(),
            name: QuizeScreen.routeName,
            binding: BindingsBuilder(() {
              Get.put<QuizController>(QuizController());
            })),
        GetPage(
            page: () => const AnswersCheckScreen(),
            name: AnswersCheckScreen.routeName),
        GetPage(
            page: () => const QuizOverviewScreen(),
            name: QuizOverviewScreen.routeName),
        GetPage(page: () => const Resultcreen(), name: Resultcreen.routeName),
      ];
}
