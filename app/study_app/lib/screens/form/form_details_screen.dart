import 'package:collectly/controllers/project_form/form_data_controller.dart';
import 'package:collectly/models/project_form_model.dart';
import 'package:collectly/widgets/form/form_detail_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:collectly/configs/configs.dart';
import 'package:collectly/controllers/controllers.dart';
import 'package:collectly/widgets/widgets.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../home/custom_drawer.dart';

class FormDetailsScreen extends GetView<MyDrawerController> {
  const FormDetailsScreen({Key? key}) : super(key: key);

  static const String routeName = '/form_details';

  static const List headers = [
    'Form Title',
    'Description',
    'Visibility',
    'Downloadability',
    'Question Count',
  ];

  List<String> getValue(FormModel model) {
    List<String> values = [];

    values.add(model.title.toString());
    values.add(model.description.toString());

    if (model.isPublic) {
      values.add(
          'Form is publically available. Anyone with the link can contribute the form');
    } else {
      values.add(
          'Form is not publically available. Only form owners and collaborators can access the form');
    }

    if (model.downloadable == 'notAvailable') {
      values.add('Downloadable sources are not available yet');
    } else if (model.downloadable == 'notAvailable') {
      values.add('You can download sources through the link');
    } else if (model.downloadable == 'processing') {
      values.add('Downloading is processing');
    }

    values.add('Number of ' +
        model.structure.length.toString() +
        ' questions are available in this form');

    return values;
  }

  @override
  Widget build(BuildContext context) {
    FormDataController _formDataContoller = Get.find();
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 2,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.visibility),
              label: "Visibility",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.share), label: "Share"),
            BottomNavigationBarItem(
              icon: Icon(Icons.play_arrow),
              label: "Play",
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.download), label: "Download"),
            BottomNavigationBarItem(icon: Icon(Icons.delete), label: "Delete")
          ],
        ),
        body: GetBuilder<MyDrawerController>(
          builder: (_) => ZoomDrawer(
            controller: _.zoomDrawerController,
            borderRadius: 50.0,
            showShadow: true,
            angle: 0.0,
            style: DrawerStyle.DefaultStyle,
            menuScreen: const CustomDrawer(),
            backgroundColor: Colors.white.withOpacity(0.5),
            slideWidth: MediaQuery.of(context).size.width * 0.6,
            mainScreen: Container(
              decoration: BoxDecoration(gradient: mainGradient()),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(kMobileScreenPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Transform.translate(
                            offset: const Offset(-10, 0),
                            child: CircularButton(
                              child: const Icon(AppIcons.menuleft),
                              onTap: controller.toggleDrawer,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                const Icon(AppIcons.peace),
                                Builder(
                                  builder: (_) {
                                    final AuthController _auth = Get.find();
                                    final user = _auth.getUser();
                                    String _label = '  Hello mate';
                                    if (user != null) {
                                      _label = '  Hello ${user.displayName}';
                                    }
                                    return Text(_label,
                                        style: kDetailsTS.copyWith(
                                            color: kOnSurfaceTextColor));
                                  },
                                ),
                              ],
                            ),
                          ),
                          const Text('FORM DETAILS', style: kHeaderTS),
                          const SizedBox(height: 15),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: ContentArea(
                          addPadding: false,
                          child: LiquidPullToRefresh(
                            height: 150,
                            springAnimationDurationInMilliseconds: 500,
                            //backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.5),
                            onRefresh: () async {},
                            child: ListView.separated(
                              padding: UIParameters.screenPadding,
                              shrinkWrap: true,
                              itemCount: headers.length,
                              itemBuilder: (BuildContext context, int index) {
                                return FormDetailCard(
                                  header: headers[index],
                                  value:
                                      getValue(_formDataContoller.form)[index],
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(
                                  height: 20,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
