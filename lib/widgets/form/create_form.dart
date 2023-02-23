import 'package:collectly/controllers/project_form/form_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyStepFormDialog extends GetView<FormController> {
  const MyStepFormDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AlertDialog(
        title: const Text('Create Form'),
        scrollable: true,
        content: Form(
          key: controller.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (controller.currentStep.toInt() == 0)
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Form Title'),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please enter a form title';
                    }
                    return null;
                  },
                  onChanged: (String? value) => controller.formName = value!,
                ),
              if (controller.currentStep.toInt() == 0)
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Form Description'),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please enter a form description';
                    }
                    return null;
                  },
                  onChanged: (String? value) =>
                      controller.formDescription = value!,
                ),
              if (controller.currentStep.toInt() == 0)
                const SizedBox(
                  height: 20,
                ),
              if (controller.currentStep.toInt() == 0)
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Visibility of the form (Is it public?)',
                  ),
                ),
              if (controller.currentStep.toInt() == 0)
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton<String>(
                    value: controller.public.value,
                    onChanged: (value) {
                      controller.public.value = value!;

                      bool temp = false;
                      if (value == 'yes') {
                        temp = true;
                      }
                      controller.isPublic = temp;
                    },
                    items: const [
                      DropdownMenuItem(
                        child: Text("Yes"),
                        value: "yes",
                      ),
                      DropdownMenuItem(
                        child: Text("No"),
                        value: "no",
                      ),
                    ],
                  ),
                ),
              if (controller.currentStep.toInt() > 0)
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Add Question ' + controller.currentStep.toString(),
                  ),
                ),
              if (controller.currentStep.toInt() > 0)
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Question Text'),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please enter the question';
                    }
                    return null;
                  },
                  onChanged: (String? value) =>
                      controller.structure[controller.currentStep.toInt()]
                          ['text'] = value!,
                ),
              if (controller.currentStep.toInt() > 0)
                const SizedBox(
                  height: 20,
                ),
              if (controller.currentStep.toInt() > 0)
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Question Type',
                  ),
                ),
              if (controller.currentStep.toInt() > 0)
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton<String>(
                    value: controller.questionType.value,
                    onChanged: (value) {
                      controller.questionType.value = value!;
                      controller.structure[controller.currentStep.toInt()]
                          ['type'] = value;
                    },
                    items: const [
                      DropdownMenuItem(
                        child: Text("Numeric"),
                        value: "numeric",
                      ),
                      DropdownMenuItem(
                        child: Text("Text"),
                        value: "text",
                      ),
                      DropdownMenuItem(
                        child: Text("Selection"),
                        value: "selection",
                      ),
                      DropdownMenuItem(
                        child: Text("Radio"),
                        value: "radio",
                      ),
                      DropdownMenuItem(
                        child: Text("Image"),
                        value: "image",
                      ),
                      DropdownMenuItem(
                        child: Text("Video"),
                        value: "video",
                      ),
                      DropdownMenuItem(
                        child: Text("Audio"),
                        value: "audio",
                      ),
                    ],
                  ),
                ),
              if (controller.currentStep.toInt() > 0)
                const SizedBox(
                  height: 20,
                ),
              if (controller.currentStep.toInt() > 0)
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Required Question',
                  ),
                ),
              if (controller.currentStep.toInt() > 0)
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton<String>(
                    value: controller.required.value,
                    onChanged: (value) {
                      controller.required.value = value!;

                      bool temp = false;
                      if (value == 'yes') {
                        temp = true;
                      }
                      controller.structure[controller.currentStep.value]
                          ['required'] = temp;
                    },
                    items: const [
                      DropdownMenuItem(
                        child: Text("Yes"),
                        value: "yes",
                      ),
                      DropdownMenuItem(
                        child: Text("No"),
                        value: "no",
                      ),
                    ],
                  ),
                ),
              if (controller.currentStep.toInt() > 0 &&
                  (controller.questionType.value == 'selection' ||
                      controller.questionType.value == 'radio'))
                const SizedBox(
                  height: 20,
                ),
              if (controller.currentStep.toInt() > 0 &&
                  (controller.questionType.value == 'selection' ||
                      controller.questionType.value == 'radio'))
                Column(
                  children: controller.choices
                      .map((element) => Text(element))
                      .toList(),
                ),
              if (controller.currentStep.toInt() > 0 &&
                  (controller.questionType.value == 'selection' ||
                      controller.questionType.value == 'radio'))
                TextFormField(
                  controller: controller.ctrl,
                  decoration:
                      const InputDecoration(labelText: 'Multiple Choices'),
                  onChanged: (String? value) => controller.choice = value!,
                ),
              if (controller.currentStep.toInt() > 0 &&
                  (controller.questionType.value == 'selection' ||
                      controller.questionType.value == 'radio'))
                TextButton(
                  child: const Text('Add Choice'),
                  onPressed: () {
                    controller.ctrl.clear();
                    if (controller.choice!.isEmpty) {
                      return;
                    }
                    if (controller.choices.isEmpty) {
                      controller.structure[controller.currentStep.value]
                          ['choices'] = [];
                    }
                    controller.choices.add(controller.choice);
                    controller.structure[controller.currentStep.value]
                            ['choices']
                        .add(controller.choice);
                  },
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              controller.formKey.currentState!.reset();
              controller.structure = [{}];
              controller.choices.value = [];
              controller.currentStep.value = 0;
              controller.required.value = 'yes';
              controller.public.value = 'no';
              controller.questionType.value = 'text';
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Continue'),
            onPressed: () {
              if (controller.formKey.currentState!.validate()) {
                controller.formKey.currentState!.reset();
                controller.currentStep++;
                controller.required.value = 'yes';
                controller.questionType.value = 'text';
                controller.structure.add({});
                controller.choices.value = [];
              }
            },
          ),
          if (controller.currentStep.value != 0)
            TextButton(
              child: const Text('Submit'),
              onPressed: () {
                if (controller.formKey.currentState!.validate()) {
                  controller.uploadData();
                  // Process form data here
                  controller.formKey.currentState!.reset();
                  controller.structure = [{}];
                  controller.choices.value = [];
                  controller.currentStep.value = 0;
                  controller.required.value = 'yes';
                  controller.public.value = 'no';
                  controller.questionType.value = 'text';
                  Navigator.of(context).pop();
                }
              },
            ),
        ],
      ),
    );
  }
}
