import 'package:collectly/controllers/form_play/play_form_controller.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:get/get.dart';
import 'package:collectly/configs/configs.dart';
import 'package:collectly/widgets/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class PlayFormScreen extends GetView<PlayFormController> {
  const PlayFormScreen({Key? key}) : super(key: key);

  static const String routeName = '/play_form_screen';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: null,
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: MyAppBar(
            titleWidget: Obx(() => Text(
                  'Question. ${(controller.questionIndex.value + 1).toString().padLeft(2, '0')}',
                  style: kAppBarTS,
                )),
          ),
          body: BackgroundDecoration(
            child: Column(
              children: [
                Expanded(
                  child: Obx(
                    () => ContentArea(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            Text(
                              controller.currentQuestion.value['text'],
                              style: kQuizeTS,
                            ),
                            const SizedBox(height: 25),
                            Column(children: [
                              if (controller.currentQuestion.value['type'] ==
                                  'text')
                                TextFormField(
                                  controller: controller.ctrl,
                                  decoration: const InputDecoration(
                                      labelText: 'Answer'),
                                  onChanged: (String? value) =>
                                      controller.answer = value!,
                                ),
                              if (controller.currentQuestion.value['type'] ==
                                  'numeric')
                                TextFormField(
                                  controller: controller.ctrl,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      labelText: 'Answer'),
                                  onChanged: (String? value) =>
                                      controller.answer = value!,
                                ),
                              if (controller.currentQuestion.value['type'] ==
                                  'selection')
                                FormBuilderCheckboxGroup(
                                  name: "selection",
                                  wrapDirection: Axis.vertical,
                                  decoration: const InputDecoration(
                                    label: Text('Answer'),
                                    border: OutlineInputBorder(),
                                  ),
                                  options: [
                                    for (int i = 0;
                                        i <
                                            controller.currentQuestion
                                                .value['choices'].length;
                                        i++)
                                      FormBuilderFieldOption<int>(
                                        value: i,
                                        child: Text(controller.currentQuestion
                                                .value['choices'][i] ??
                                            'Not provided'),
                                      )
                                  ],
                                  onChanged: (List<int>? value) {
                                    if (value != null) {
                                      controller.answer = "";
                                      for (int idx = 0;
                                          idx < value.length;
                                          idx++) {
                                        if (idx != 0) {
                                          controller.answer =
                                              controller.answer.toString() +
                                                  ",";
                                        }
                                        controller.answer = controller.answer
                                                .toString() +
                                            controller.currentQuestion
                                                .value['choices'][value[idx]]
                                                .toString();
                                      }
                                    }
                                  },
                                ),
                              if (controller.currentQuestion.value['type'] ==
                                  'radio')
                                FormBuilderRadioGroup(
                                  name: 'radio',
                                  wrapDirection: Axis.vertical,
                                  decoration: const InputDecoration(
                                    label: Text('Answer'),
                                    border: OutlineInputBorder(),
                                  ),
                                  options: [
                                    for (int i = 0;
                                        i <
                                            controller.currentQuestion
                                                .value['choices'].length;
                                        i++)
                                      FormBuilderFieldOption<int>(
                                        value: i,
                                        child: Text(controller.currentQuestion
                                                .value['choices'][i] ??
                                            'Not provided'),
                                      )
                                  ],
                                  onChanged: (int? value) {
                                    controller.answer = controller
                                        .currentQuestion
                                        .value['choices'][value];
                                  },
                                ),
                              if (controller.currentQuestion.value['type'] ==
                                  'image')
                                FormBuilderImagePicker(
                                  name: 'image',
                                  decoration: const InputDecoration(
                                    label: Text("Answer as an Image"),
                                    border: OutlineInputBorder(),
                                  ),
                                  maxImages: 1,
                                  onChanged: (value) {
                                    if (value != null) {
                                      controller.answer = value[0].path;
                                    }
                                  },
                                ),
                              if (controller.currentQuestion.value['type'] ==
                                  'video')
                                FormBuilderFilePicker(
                                  name: "video",
                                  decoration: const InputDecoration(
                                    label: Text("Answer as a Video"),
                                    border: OutlineInputBorder(),
                                  ),
                                  type: FileType.video,
                                  maxFiles: 1,
                                  previewImages: true,
                                  onChanged: (value) {
                                    if (value != null) {
                                      controller.answer = value[0].path;
                                    }
                                  },
                                ),
                              if (controller.currentQuestion.value['type'] ==
                                  'audio')
                                FormBuilderFilePicker(
                                  name: "audio",
                                  decoration: const InputDecoration(
                                    label: Text("Answer as a Audio"),
                                    border: OutlineInputBorder(),
                                  ),
                                  type: FileType.audio,
                                  maxFiles: 1,
                                  previewImages: true,
                                  onChanged: (value) {
                                    if (value != null) {
                                      controller.answer = value[0].path;
                                    }
                                  },
                                )
                            ]),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                ColoredBox(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Padding(
                    padding: UIParameters.screenPadding,
                    child: Row(
                      children: [
                        Expanded(
                          child: Obx(
                            () => Visibility(
                              child: MainButton(
                                onTap: () {
                                  if (controller.currentQuestion
                                          .value['required'] as bool ==
                                      true) {
                                    if (controller.answer == null ||
                                        controller.answer == "") {
                                      return;
                                    }
                                  }
                                  controller.submitAnswer();
                                  controller.ctrl.clear();
                                  controller.answer = "";
                                  controller.islastQuestion
                                      ? controller.navigateToHome()
                                      : controller.nextQuestion();
                                },
                                title: controller.islastQuestion
                                    ? 'Complete'
                                    : 'Submit Answer - Q ' +
                                        (controller.questionIndex.value + 1)
                                            .toString()
                                            .padLeft(2, '0'),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
