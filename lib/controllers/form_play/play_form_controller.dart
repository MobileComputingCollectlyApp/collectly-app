import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collectly/models/project_form_model.dart';
import 'package:collectly/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:collectly/firebase/firebase_configs.dart';
import 'package:collectly/screens/screens.dart';
import 'package:uuid/uuid.dart';

class PlayFormController extends GetxController {
  final loadingStatus = LoadingStatus.completed.obs;
  late List<dynamic> allQuestions;
  late FormModel formModel;
  late String projectID;
  String? answer;
  String? dataID;
  TextEditingController ctrl = TextEditingController();

  Rxn<dynamic> currentQuestion = Rxn<dynamic>();
  // current question index
  final questionIndex = 0.obs;

  @override
  void onInit() {
    final temp = Get.arguments;
    formModel = temp['form'] as FormModel;
    allQuestions = formModel.structure;
    currentQuestion.value = allQuestions[0];
    projectID = temp['project_id'];
    super.onInit();
  }

  bool get isFirstQuestion => questionIndex.value == 0;

  bool get islastQuestion => questionIndex.value == allQuestions.length - 1;

  void nextQuestion() {
    if (questionIndex.value >= allQuestions.length - 1) return;
    questionIndex.value++;
    currentQuestion.value = allQuestions[questionIndex.value];
  }

  void submitAnswer() async {
    const uuid = Uuid();
    dataID ??= uuid.v4();
    final id = uuid.v4();

    if (currentQuestion.value['type'] == 'image') {
      File file = File(answer!);
      final splits = answer!.split(".");
      await firebaseStorage
          .child("public/images/" +
              id.toString() +
              "." +
              splits[splits.length - 1])
          .putFile(file);
      answer = id + "." + splits[splits.length - 1];
    } else if (currentQuestion.value['type'] == 'video') {
      File file = File(answer!);
      final splits = answer!.split(".");
      await firebaseStorage
          .child("public/videos/" +
              id.toString() +
              "." +
              splits[splits.length - 1])
          .putFile(file);
      answer = id + "." + splits[splits.length - 1];
    } else if (currentQuestion.value['type'] == 'audio') {
      File file = File(answer!);
      final splits = answer!.split(".");
      await firebaseStorage
          .child("public/audios/" +
              id.toString() +
              "." +
              splits[splits.length - 1])
          .putFile(file);
      answer = id + "." + splits[splits.length - 1];
    }

    try {
      await projectFormFR
          .doc(projectID)
          .collection("forms")
          .doc(formModel.id)
          .collection("data")
          .doc(dataID)
          .set({
        currentQuestion.value['id'].toString(): answer,
      }, SetOptions(merge: true));
    } on Exception catch (e) {
      AppLogger.e(e);
    }
  }

  void navigateToHome() {
    Get.offNamedUntil(HomeScreen.routeName, (route) => false);
  }
}
