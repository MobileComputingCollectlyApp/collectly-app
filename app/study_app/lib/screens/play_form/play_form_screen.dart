import 'package:collectly/controllers/form_play/play_form_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:collectly/configs/configs.dart';
import 'package:collectly/widgets/widgets.dart';

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
                  child: ContentArea(
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
                            TextFormField(
                              controller: controller.ctrl,
                              decoration:
                                  const InputDecoration(labelText: 'Answer'),
                              onChanged: (String? value) =>
                                  controller.answer = value!,
                            ),
                          ]),
                        ],
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
                                  controller.submitAnswer();
                                  controller.ctrl.clear();
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
