import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

// Project model in firestore
class ProjectModel {
  final String id;
  final String title;
  final String description;
  List<Form>? forms;
  final int formsCount;
  final String owner;
  final List<String> collaborators;

  ProjectModel({
    required this.id,
    required this.title,
    required this.description,
    required this.forms,
    required this.formsCount,
    required this.owner,
    required this.collaborators,
  });

  factory ProjectModel.fromString(String jsonString) =>
      ProjectModel.fromJson(json.decode(jsonString));

  ProjectModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'] as String,
        description = json['description'] as String,
        formsCount = json['forms'] == null ? 0 : (json['forms'] as List).length,
        forms = json['forms'] == null
            ? []
            : (json['forms'] as List)
                .map((dynamic e) => Form.fromJson(e as Map<String, dynamic>))
                .toList(),
        owner = json['owner'],
        collaborators = json['collaborators'] == null
            ? []
            : json['collaborators'] as List<String>;

  ProjectModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        title = snapshot['title'],
        description = snapshot['description'],
        formsCount = snapshot['forms_count'] as int,
        forms = [],
        owner = '',
        collaborators = [];

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'forms_count': formsCount,
        'owner': owner
      };
}

// Form models inside the project
class Form {
  final String id;
  final String title;
  final String description;
  final bool isPublic;
  final String downloadable;
  final Map<String, dynamic> structure;
  List<Answer> answers;

  Form({
    required this.id,
    required this.title,
    required this.description,
    required this.isPublic,
    required this.downloadable,
    required this.structure,
    required this.answers,
  });

  Form.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        title = snapshot['title'],
        description = snapshot['description'],
        isPublic = snapshot['isPublic'],
        downloadable = snapshot['downloadable'],
        structure = snapshot['structure'],
        answers = [];

  Form.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        title = json['title'] as String,
        description = json['description'] as String,
        isPublic = json['isPublic'] as bool,
        downloadable = json['downloadable'] as String,
        structure = json['structure'] as Map<String, dynamic>,
        answers = json['answers'] == null
            ? []
            : (json['answers'] as List).map((e) => Answer.fromJson(e)).toList();

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'isPublic': isPublic,
        'downloadable': downloadable
      };
}

// Answer model for each form
class Answer {
  final String id;
  final Map<String, dynamic> answers;

  Answer({
    required this.id,
    required this.answers,
  });

  Answer.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        answers = json['answers'] as Map<String, String>;

  Answer.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot['id'] as String,
        answers = {};

  Map<String, dynamic> toJson() => {'id': id, 'answers': answers};
}
