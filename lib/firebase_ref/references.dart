import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final fireStore = FirebaseFirestore.instance;

// final questionPaperRF = fireStore.collection("questionPapers");

// DocumentReference questionRF({
//   required String paperId,
//   required String questionId,
// }) =>
//     questionPaperRF.doc(paperId).collection("questions").doc(questionId);

// DocumentReference answerRF({
//   required String paperId,
//   required String questionId,
//   required String answerId,
// }) =>
//     questionRF(paperId: paperId, questionId: questionId)
//         .collection("answers")
//         .doc(answerId);

Reference get firebaseStorage => FirebaseStorage.instance.ref();
