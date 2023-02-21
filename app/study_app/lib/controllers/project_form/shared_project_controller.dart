import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collectly/controllers/auth_controller.dart';
import 'package:collectly/models/project_form_model.dart';
import 'package:collectly/screens/screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:collectly/firebase/firebase_configs.dart';
import 'package:collectly/utils/logger.dart';

class SharedProjectController extends GetxController {
  final AuthController _auth = Get.find();
  late User? user;

  @override
  void onReady() {
    user = _auth.getUser();
    if (user == null) {
      _auth.showLoginAlertDialog();
      return;
    }

    getAllProjects();
    super.onReady();
  }

  final allProjects = <ProjectModel>[].obs;

  // Get all projects created by current user
  Future<void> getAllProjects() async {
    try {
      QuerySnapshot<Map<String, dynamic>> data = await projectFormFR
          .where("collaborators", arrayContains: user?.email)
          .get();
      final projectList = data.docs
          .map((project) => ProjectModel.fromSnapshot(project))
          .toList();
      allProjects.assignAll(projectList);
    } catch (e) {
      AppLogger.e(e);
    }
  }

  // Navigate to the form section of the project
  void navigatoForms({required ProjectModel project, bool isTryAgain = false}) {
    AuthController _authController = Get.find();

    if (_authController.isLogedIn()) {
      if (isTryAgain) {
        Get.back();
        Get.offNamed(FormScreen.routeName,
            arguments: project, preventDuplicates: false);
      } else {
        Get.toNamed(FormScreen.routeName, arguments: project);
      }
    } else {
      Get.toNamed(FormScreen.routeName, arguments: project);
      _authController.showLoginAlertDialog();
    }
  }

  // Navigate to the My Project list
  void navigatoMyFolder() {
    if (_auth.isLogedIn()) {
      Get.toNamed(HomeScreen.routeName);
    } else {
      _auth.showLoginAlertDialog();
    }
  }
}
