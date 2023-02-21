import 'package:collectly/models/project_form_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:collectly/firebase/firebase_configs.dart';
import 'package:collectly/utils/logger.dart';

class ProjectController extends GetxController {
  final formKey = GlobalKey<FormState>();
  String? projectName;
  String? projectDescription;

  @override
  void onReady() {
    super.onReady();
  }

  final loadingStatus = LoadingStatus.loading.obs;

  // Upload project creation data to firestore
  uploadData({required ProjectModel data}) async {
    loadingStatus.value = LoadingStatus.loading; // State for loading component

    try {
      await projectFormFR.doc(data.id).set({
        "title": data.title,
        "description": data.description,
        "forms": data.forms,
        "forms_count": data.formsCount,
        "owner": data.owner,
        "collaborators": data.collaborators,
      });

      loadingStatus.value = LoadingStatus.completed;
    } on Exception catch (e) {
      loadingStatus.value = LoadingStatus.error;
      AppLogger.e(e);
    }
  }
}
