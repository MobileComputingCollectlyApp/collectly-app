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

class FormDataController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final AuthController _auth = Get.find();
  late User? user;
  late FormModel form;

  @override
  void onInit() {
    form = Get.arguments as FormModel;
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

  // Upload project creation data to firestore
  // uploadData() async {
  //   const uuid = Uuid();
  //   String projectID = uuid.v4();

  //   try {
  //     await projectFormFR.doc(projectID).set({
  //       "id": projectID,
  //       "forms_count": 0,
  //       "owner": user?.email,
  //       "collaborators": [],
  //     });
  //     _auth.navigateToHome();
  //   } on Exception catch (e) {
  //     AppLogger.e(e);
  //   }
  // }

  // Share project with other members
  // addMember(String id) async {
  //   try {
  //     await projectFormFR
  //         .doc(id)
  //         .update({"collaborators": FieldValue.arrayUnion()});
  //   } on Exception catch (e) {
  //     AppLogger.e(e);
  //   }
  // }

  // Delete Project
  // deleteProject(String id) async {
  //   try {
  //     await projectFormFR.doc(id).delete();
  //     _auth.navigateToHome();
  //   } on Exception catch (e) {
  //     AppLogger.e(e);
  //   }
  // }
}
