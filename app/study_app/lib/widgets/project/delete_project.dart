import 'package:collectly/controllers/project_form/project_controller.dart';
import 'package:collectly/models/project_form_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteProjectDialog extends GetView<ProjectController> {
  const DeleteProjectDialog({Key? key, required this.project})
      : super(key: key);

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete Project'),
      content: Form(
        key: controller.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
                'Are you sure delete this project. This will remove all your details related to this project.'),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Delete'),
          onPressed: () {
            controller.deleteProject(project.id);
          },
        ),
      ],
    );
  }
}
