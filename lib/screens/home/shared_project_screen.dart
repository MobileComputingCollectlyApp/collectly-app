import 'package:collectly/controllers/project_form/shared_project_controller.dart';
import 'package:collectly/widgets/home/project_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:collectly/configs/configs.dart';
import 'package:collectly/controllers/controllers.dart';
import 'package:collectly/widgets/widgets.dart';

import 'custom_drawer.dart';

class SharedProjectScreen extends GetView<MyDrawerController> {
  const SharedProjectScreen({Key? key}) : super(key: key);

  static const String routeName = '/shared_projects';

  @override
  Widget build(BuildContext context) {
    SharedProjectController _projectController = Get.find();
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 1,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.folder), label: "My Projects"),
            BottomNavigationBarItem(
                icon: Icon(Icons.folder_shared), label: "Shared Projects"),
          ],
          onTap: (index) => {
            if (index == 0) {_projectController.navigatoMyFolder()}
          },
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
                          const Text('SHARED PROJECTS', style: kHeaderTS),
                          const SizedBox(height: 15),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: ContentArea(
                          addPadding: false,
                          child: Obx(
                            () => LiquidPullToRefresh(
                              height: 150,
                              springAnimationDurationInMilliseconds: 500,
                              //backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.5),
                              onRefresh: () async {
                                _projectController.getAllProjects();
                              },
                              child: ListView.separated(
                                padding: UIParameters.screenPadding,
                                shrinkWrap: true,
                                itemCount:
                                    _projectController.allProjects.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ProjectCard(
                                    model:
                                        _projectController.allProjects[index],
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
