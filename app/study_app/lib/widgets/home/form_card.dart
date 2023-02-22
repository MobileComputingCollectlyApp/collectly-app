import 'package:collectly/controllers/project_form/form_controller.dart';
import 'package:collectly/models/project_form_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:collectly/configs/configs.dart';

class FormCard extends GetView<FormController> {
  const FormCard({Key? key, required this.model}) : super(key: key);

  final FormModel model;

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
          controller.navigatoForm(form: model);
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
                              'assets/images/form.jpeg',
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
