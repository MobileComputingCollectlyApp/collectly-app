import 'package:collectly/controllers/auth_controller.dart';
import 'package:collectly/models/project_form_model.dart';
import 'package:collectly/screens/play_form/play_form_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormDataController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final AuthController _auth = Get.find();
  late User? user;
  late FormModel form;
  late String projectID;

  @override
  void onInit() {
    final temp = Get.arguments;
    form = temp['form'] as FormModel;
    projectID = temp['project_id'];
    super.onInit();
  }

  @override
  void onReady() {
    user = _auth.getUser();
    if (user == null) {
      _auth.showLoginAlertDialog();
      return;
    }

    super.onReady();
  }

  // Use to navigate to the form play overview page
  void navigateToFormPlayScreen() {
    final params = {'form': form, 'project_id': projectID};

    if (_auth.isLogedIn()) {
      Get.toNamed(PlayFormScreen.routeName, arguments: params);
    } else {
      Get.toNamed(PlayFormScreen.routeName, arguments: params);
      _auth.showLoginAlertDialog();
    }
  }
}
