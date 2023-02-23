import 'package:collectly/controllers/project_form/project_controller.dart';
import 'package:collectly/models/project_form_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddMemberDialog extends GetView<ProjectController> {
  const AddMemberDialog({Key? key, required this.project}) : super(key: key);

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Share Project'),
      content: Form(
        key: controller.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email Address'),
              validator: (String? value) {
                if (value!.isEmpty) {
                  return 'Please enter an email of new member';
                } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                  return "Please enter a valid email address";
                }
                return null;
              },
              onChanged: (String? value) =>
                  controller.collaborators = value == null ? [] : [value],
            )
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
          child: const Text('Share'),
          onPressed: () {
            if (controller.formKey.currentState!.validate()) {
              controller.formKey.currentState!.save();
              controller.addMember(project.id);
              // Process form data here
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
