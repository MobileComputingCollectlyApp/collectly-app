import 'package:flutter/material.dart';
import 'package:collectly/configs/configs.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key, this.title = '', this.titleWidget})
      : super(key: key);

  final String title;
  final Widget? titleWidget;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kMobileScreenPadding,
              vertical: kMobileScreenPadding / 1.2),
          child: Stack(
            children: [
              Positioned.fill(
                child: titleWidget == null
                    ? Center(child: Text(title, style: kAppBarTS))
                    : Center(child: titleWidget!),
              ),
            ],
          )),
    );
  }

  @override
  Size get preferredSize => const Size(
        double.maxFinite,
        80,
      );
}
