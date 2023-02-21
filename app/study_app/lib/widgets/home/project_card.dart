import 'package:collectly/controllers/project_form/project_controller.dart';
import 'package:collectly/models/project_form_model.dart';
import 'package:easy_separator/easy_separator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:collectly/configs/configs.dart';
import 'package:collectly/widgets/widgets.dart';

class ProjectCard extends GetView<ProjectController> {
  const ProjectCard({Key? key, required this.model}) : super(key: key);

  final ProjectModel model;

  @override
  Widget build(BuildContext context) {
    const double _padding = 10.0;
    return Ink(
      decoration: BoxDecoration(
        borderRadius: UIParameters.cardBorderRadius,
        color: Theme.of(context).cardColor,
      ),
      child: InkWell(
        borderRadius: UIParameters.cardBorderRadius,
        onTap: () {
          controller.navigatoQuestions(project: model);
        },
        child: Padding(
            padding: const EdgeInsets.all(_padding),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //showing the image
                    ClipRRect(
                      borderRadius: UIParameters.cardBorderRadius,
                      child: ColoredBox(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.2),
                          child: SizedBox(
                            width: 65,
                            height: 65,
                            child: Image.asset(
                              'assets/images/splash.png',
                            ),
                          )),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    //question and other things
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //title of the paper
                        Text(
                          model.title,
                          style: cardTitleTs(context),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 15),
                          child: Text(model.description),
                        ),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: EasySeparatedRow(
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(width: 15);
                            },
                            children: [
                              IconWithText(
                                  icon: Icon(Icons.collections,
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Theme.of(context).primaryColor),
                                  text: Text(
                                    '${model.formsCount} formes',
                                    style: kDetailsTS.copyWith(
                                        color: Get.isDarkMode
                                            ? Colors.white
                                            : Theme.of(context).primaryColor),
                                  )),
                              IconWithText(
                                  icon: Icon(Icons.group,
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Theme.of(context).primaryColor),
                                  text: Text(
                                    model.collaborators.isEmpty
                                        ? "Not Shared"
                                        : "Shared Project",
                                    style: kDetailsTS.copyWith(
                                        color: Get.isDarkMode
                                            ? Colors.white
                                            : Theme.of(context).primaryColor),
                                  )),
                            ],
                          ),
                        )
                      ],
                    ))
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
