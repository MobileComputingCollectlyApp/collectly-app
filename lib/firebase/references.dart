import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

// All references to the firestore
final fi = FirebaseFirestore.instance;

final userFR = fi.collection('users');
final projectFormFR = fi.collection('projects');

// Reference to the firebase storage
Reference get firebaseStorage => FirebaseStorage.instance.ref();
