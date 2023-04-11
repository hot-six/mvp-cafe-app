import 'package:flutter/material.dart';

class ColoredTabBarWithBottomBorder extends Container
    implements PreferredSizeWidget {
  ColoredTabBarWithBottomBorder({
    required this.tabBar,
  });

  final TabBar tabBar;

  @override
  Size get preferredSize => tabBar.preferredSize;

  @override
  Widget build(BuildContext context) => Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              // set left to 0 and right to 0 to expand
              // ref: https://stackoverflow.com/questions/55191868/flutter-ui-absolute-positioned-element-with-fixed-height-and-100-width
              left: 0,
              right: 0,
              // to the bottom
              bottom: 0,
              child: Container(
                height: 1,
                color: Colors.white,
              ),
            ),
            tabBar,
          ],
        ),
      );
}
