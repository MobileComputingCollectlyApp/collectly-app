import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collectly/controllers/auth_controller.dart';
import 'package:collectly/models/project_form_model.dart';
import 'package:collectly/screens/home/shared_project_screen.dart';
import 'package:collectly/screens/screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:collectly/firebase/firebase_configs.dart';
import 'package:collectly/utils/logger.dart';

class ProjectController extends GetxController {
  final formKey = GlobalKey<FormState>();
  String? projectName;
  String? projectDescription;
  List<String> collaborators = [];
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
      QuerySnapshot<Map<String, dynamic>> data =
          await projectFormFR.where("owner", isEqualTo: user?.email).get();
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

  // Navigate to the Shared Project Folder
  void navigatoSharedFolder() {
    if (_auth.isLogedIn()) {
      Get.toNamed(SharedProjectScreen.routeName);
    } else {
      _auth.showLoginAlertDialog();
    }
  }

  // Upload project creation data to firestore
  uploadData() async {
    const uuid = Uuid();
    String projectID = uuid.v4();

    try {
      await projectFormFR.doc(projectID).set({
        "id": projectID,
        "title": projectName,
        "description": projectDescription,
        "forms_count": 0,
        "owner": user?.email,
        "collaborators": [],
      });
      _auth.navigateToHome();
    } on Exception catch (e) {
      AppLogger.e(e);
    }
  }

  // Update project data in firestore
  updateData(String id) async {
    try {
      Map<String, String> temp = {};
      if (projectName != null || projectDescription != null) {
        if (projectName != null) {
          temp['title'] = projectName!;
        }
        if (projectDescription != null) {
          temp['description'] = projectDescription!;
        }
      } else {
        return;
      }
      await projectFormFR.doc(id).set(temp, SetOptions(merge: true));
      _auth.navigateToHome();
    } on Exception catch (e) {
      AppLogger.e(e);
    }
  }

  // Share project with other members
  addMember(String id) async {
    try {
      await projectFormFR
          .doc(id)
          .update({"collaborators": FieldValue.arrayUnion(collaborators)});
    } on Exception catch (e) {
      AppLogger.e(e);
    }
  }

  // Delete Project
  deleteProject(String id) async {
    try {
      await projectFormFR.doc(id).delete();
      _auth.navigateToHome();
    } on Exception catch (e) {
      AppLogger.e(e);
    }
  }
}
