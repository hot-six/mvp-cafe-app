import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nado_client_mvp/app/concept/colors.dart';

class NadoAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Image.asset(
          'assets/images/appbar_title.png',
        ),
      ),
      // title: userTypeToggle(),
      actions: [
        Image.asset('assets/images/thumb.png'),
      ],
      titleSpacing: 20.0,
      leadingWidth: 115.0,
      shape: Border(
        bottom: BorderSide(color: NadoColor.greyColor, width: 1),
      ),
      elevation: 0.0,
    );
  }

  Widget userTypeToggle() {
    return Container(
        width: 147.0,
        height: 32.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: NadoColor.greyColor[100],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            userTypeBlock('손님'),
            userTypeBlock('사장님'),
          ],
        ));

    // return ToggleButtons(children: [
    //   userTypeBlock('손님'),
    //   userTypeBlock('사장님'),
    // ], isSelected: [
    //   true,
    //   false
    // ]);
  }

  Widget userTypeBlock(String title) {
    return Container(
        decoration: BoxDecoration(
          color: NadoColor.primary,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: HexColor('##82c69d80'),
              blurRadius: 5.0,
              spreadRadius: 0.0,
              offset: Offset(0, 7),
            )
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ));
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
