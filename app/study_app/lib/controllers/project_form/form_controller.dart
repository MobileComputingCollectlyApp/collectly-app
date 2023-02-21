import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collectly/controllers/auth_controller.dart';
import 'package:collectly/models/project_form_model.dart';
import 'package:collectly/screens/screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:collectly/firebase/firebase_configs.dart';
import 'package:collectly/utils/logger.dart';
import 'package:uuid/uuid.dart';

class FormController extends GetxController {
  final formKey = GlobalKey<FormState>();
  String? formName;
  String? formDescription;
  String? questionText;
  RxString questionType = 'text'.obs;
  RxString required = 'yes'.obs;
  RxString public = 'no'.obs;
  bool isPublic = false;
  RxInt currentStep = 0.obs;
  List<Map<String, dynamic>> structure = [{}];
  RxList choices = [].obs;
  String? choice;
  final AuthController _auth = Get.find();
  late User? user;
  late ProjectModel project;
  TextEditingController ctrl = TextEditingController();

  @override
  void onReady() {
    user = _auth.getUser();
    if (user == null) {
      _auth.showLoginAlertDialog();
      return;
    }
    project = Get.arguments as ProjectModel;

    getAllForms();
    super.onReady();
  }

  final allForms = <FormModel>[].obs;

  // Get all forms related to a project
  Future<void> getAllForms() async {
    try {
      QuerySnapshot<Map<String, dynamic>> data =
          await projectFormFR.doc(project.id).collection('forms').get();
      final formList =
          data.docs.map((project) => FormModel.fromSnapshot(project)).toList();
      allForms.assignAll(formList);
    } catch (e) {
      AppLogger.e(e);
    }
  }

  // Navigate to the form detatils section of the selected form
  void navigatoForm({required FormModel form, bool isTryAgain = false}) {
    AuthController _authController = Get.find();

    if (_authController.isLogedIn()) {
      if (isTryAgain) {
        Get.back();
        Get.offNamed(FormDetailsScreen.routeName,
            arguments: form, preventDuplicates: false);
      } else {
        Get.toNamed(FormDetailsScreen.routeName, arguments: form);
      }
    } else {
      Get.toNamed(FormDetailsScreen.routeName, arguments: form);
      _authController.showLoginAlertDialog();
    }
  }

  // Upload form creation data to firestore
  uploadData() async {
    const uuid = Uuid();
    String formID = uuid.v4();

    int count = 0;
    for (var element in structure) {
      element['id'] = count;
      if (element['type'] == null) {
        element['type'] = 'text';
      }
      if (element['required'] == null) {
        element['required'] = 'yes';
      }
      count++;
    }

    try {
      await projectFormFR.doc(project.id).collection('forms').doc(formID).set({
        "id": formID,
        "title": formName,
        "description": formDescription,
        "isPublic": isPublic,
        "downloadable": 'notAvailable',
        "structure": structure
      });
    } on Exception catch (e) {
      AppLogger.e(e);
    }
  }
}
