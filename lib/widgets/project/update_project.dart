import 'package:collectly/controllers/project_form/project_controller.dart';
import 'package:collectly/models/project_form_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProjectUpdateDialog extends GetView<ProjectController> {
  const ProjectUpdateDialog({Key? key, required this.project})
      : super(key: key);

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Update Project'),
      content: Form(
        key: controller.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: project.title,
              decoration: const InputDecoration(labelText: 'Project Title'),
              validator: (String? value) {
                if (value!.isEmpty) {
                  return 'Please enter a project title';
                }
                return null;
              },
              onChanged: (String? value) => controller.projectName = value!,
            ),
            TextFormField(
              initialValue: project.description,
              decoration:
                  const InputDecoration(labelText: 'Project Description'),
              validator: (String? value) {
                if (value!.isEmpty) {
                  return 'Please enter a project description';
                }
                return null;
              },
              onChanged: (String? value) =>
                  controller.projectDescription = value!,
            ),
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
          child: const Text('Update'),
          onPressed: () {
            if (controller.formKey.currentState!.validate()) {
              controller.formKey.currentState!.save();
              controller.updateData(project.id);
              // Process form data here
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
