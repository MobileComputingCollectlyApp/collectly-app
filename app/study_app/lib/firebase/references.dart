import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

// All references to the firestore
final fi = FirebaseFirestore.instance;

final userFR = fi.collection('users');
final quizePaperFR = fi.collection('quizpapers');
final projectFormFR = fi.collection('projects');
final leaderBoardFR = fi.collection('leaderboard');

DocumentReference recentQuizesData(
        {required String userId, required String paperId}) =>
    userFR.doc(userId).collection('myrecent_quizes').doc(paperId);

CollectionReference<Map<String, dynamic>> recentQuizes(
        {required String userId}) =>
    userFR.doc(userId).collection('myrecent_quizes');

CollectionReference<Map<String, dynamic>> getleaderBoard(
        {required String paperId}) =>
    leaderBoardFR.doc(paperId).collection('scores');

DocumentReference questionsFR(
        {required String paperId, required String questionsId}) =>
    quizePaperFR.doc(paperId).collection('questions').doc(questionsId);

// Reference to the firebase storage
Reference get firebaseStorage => FirebaseStorage.instance.ref();
