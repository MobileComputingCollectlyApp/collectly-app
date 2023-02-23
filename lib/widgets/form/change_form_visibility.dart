import 'package:collectly/controllers/project_form/form_controller.dart';
import 'package:collectly/models/project_form_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormVisibityDialog extends GetView<FormController> {
  const FormVisibityDialog({Key? key, required this.form}) : super(key: key);

  final FormModel form;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Form Visibility'),
      content: Form(
        key: controller.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (form.isPublic == true)
              const Text('Do you want to make this form as Private.'),
            if (form.isPublic == false)
              const Text('Do you want to make this form as Public.'),
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
          child: const Text('Proceed'),
          onPressed: () {
            controller.changeVisibility(form);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
