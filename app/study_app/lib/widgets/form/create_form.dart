import 'package:flutter/material.dart';

class MyStepFormDialog extends StatefulWidget {
  @override
  _MyStepFormDialogState createState() => _MyStepFormDialogState();
}

class _MyStepFormDialogState extends State<MyStepFormDialog> {
  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _description = '';
  String _selectedOption = 'option1';

  final List<String> _questionTypes = [
    'Numeric',
    'Text',
    'Selection',
    'Radio',
    'Image',
    'Video',
    'Audio'
  ];
  List<String> _qtype = [];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Stepper(
          currentStep: _currentStep,
          onStepContinue: () {
            setState(() {
              if (_currentStep < 2) {
                _currentStep++;
              }
            });
          },
          onStepCancel: () {
            setState(() {
              if (_currentStep > 0) {
                _currentStep--;
              }
            });
          },
          steps: [
            Step(
                title: Text('Form Details'),
                isActive: _currentStep == 0,
                content: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Name',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter form name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _name = value!;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Description',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter form description';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _description = value!;
                      },
                    ),
                  ],
                )),
            Step(
                title: Text('Add Questions'),
                isActive: _currentStep == 1,
                content: Column(
                  children: [
                    Text('Choose Question Type'),
                    DropdownButton<String>(
                      value: _selectedOption,
                      hint: Text('Select an option'),
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value!;
                        });
                      },
                      items: [
                        DropdownMenuItem(
                          child: Text('Option 1'),
                          value: 'option1',
                        ),
                        DropdownMenuItem(
                          child: Text('Option 2'),
                          value: 'option2',
                        ),
                      ],
                    ),
                    if (_selectedOption == 'option2')
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Enter some text',
                        ),
                      ),
                  ],
                )),
            Step(
                title: Text('Confirm'),
                isActive: _currentStep == 2,
                content: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Name',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _name = value!;
                      },
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
