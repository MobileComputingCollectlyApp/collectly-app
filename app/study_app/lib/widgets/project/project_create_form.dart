import 'package:flutter/material.dart';

class MyFormDialog extends StatefulWidget {
  const MyFormDialog({Key? key}) : super(key: key);

  @override
  _MyFormDialogState createState() => _MyFormDialogState();
}

class _MyFormDialogState extends State<MyFormDialog> {
  // Define form fields here
  final _formKey = GlobalKey<FormState>();
  String? _projectName;
  String? _projectDescription;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create Project'),
      content: Form(
        key: _formKey,
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
              onChanged: (String? value) => _projectName = value!,
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
              onChanged: (String? value) => _projectDescription = value!,
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
            debugPrint(
                "-------------------------------------------------------------output");
            debugPrint(_projectName);
            debugPrint(_projectDescription);
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              // Process form data here
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
