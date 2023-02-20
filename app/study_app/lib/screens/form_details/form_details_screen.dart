import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:collectly/configs/configs.dart';
import 'package:collectly/controllers/controllers.dart';
import 'package:collectly/widgets/widgets.dart';

import 'custom_drawer.dart';

class FormDetailsScreen extends GetView<MyDrawerController> {
  const FormDetailsScreen({Key? key}) : super(key: key);

  static const String routeName = '/form_details';

  @override
  Widget build(BuildContext context) {
    QuizPaperController _quizePprContoller = Get.find();
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 3,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Settings"),
            BottomNavigationBarItem(icon: Icon(Icons.share), label: "Share"),
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
                          const Text('DETAILS', style: kHeaderTS),
                          const SizedBox(height: 15),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
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
