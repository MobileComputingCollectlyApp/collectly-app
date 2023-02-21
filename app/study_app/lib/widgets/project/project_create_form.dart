import 'package:collectly/controllers/project_form/project_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyFormDialog extends GetView<ProjectController> {
  const MyFormDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create Project'),
      content: Form(
        key: controller.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
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
          child: const Text('Create'),
          onPressed: () {
            if (controller.formKey.currentState!.validate()) {
              controller.formKey.currentState!.save();
              controller.uploadData();
              // Process form data here
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
