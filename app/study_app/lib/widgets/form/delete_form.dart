import 'package:collectly/controllers/project_form/form_controller.dart';
import 'package:collectly/models/project_form_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteFormDialog extends GetView<FormController> {
  const DeleteFormDialog({Key? key, required this.form}) : super(key: key);

  final FormModel form;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete Form'),
      content: Form(
        key: controller.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
                'Are you sure delete this form. This will remove all your details related to this form.'),
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
            controller.delete(form);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
