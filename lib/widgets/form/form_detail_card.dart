import 'package:collectly/controllers/project_form/form_controller.dart';
import 'package:collectly/models/project_form_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:collectly/configs/configs.dart';

class FormDetailCard extends GetView<FormController> {
  const FormDetailCard({Key? key, required this.value, required this.header})
      : super(key: key);

  final String value;
  final String header;

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
        onTap: () {},
        child: Padding(
            padding: const EdgeInsets.all(_padding),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            header,
                            style: cardTitleTs(context),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 15),
                            child: Text(value),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
