import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nado_client_mvp/app/core/values/colors.dart';
import 'package:nado_client_mvp/app/global_widgets/appbar/logic.dart';
import 'package:nado_client_mvp/app/routes/routes.dart';

class NadoAppBar extends StatelessWidget with PreferredSizeWidget {
  final NadoAppBarLogic appBarLogic =
      Get.put(NadoAppBarLogic(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Image.asset(
          'assets/images/appbar_title.png',
        ),
      ),
      title: userTypeToggle(context),
      actions: [
        InkWell(
          onTap: () {
            Get.toNamed(Routes.FAQ);
          },
          child: Image.asset('assets/images/thumb.png'),
        ),
      ],
      titleSpacing: 20.0,
      leadingWidth: 115.0,
      shape: Border(
        bottom: BorderSide(color: NadoColor.greyColor, width: 1),
      ),
      elevation: 0.0,
    );
  }

  Widget userTypeToggle(BuildContext context) {
    return InkWell(
      onTap: appBarLogic.onTapUserChangeToggle,
      child: Obx(
        () => Container(
          width: 150,
          height: 30,
          decoration: BoxDecoration(
            color: NadoColor.greyColor[100],
            borderRadius: BorderRadius.circular(100.0),
          ),
          child: Stack(
            children: <Widget>[
              AnimatedPositioned(
                width: 75,
                height: 30,
                left: appBarLogic.isClient.value ? 0 : 75,
                duration: const Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    color: NadoColor.primary,
                    boxShadow: [
                      BoxShadow(
                        color: HexColor('##82c69d50'),
                        blurRadius: 3.0,
                        spreadRadius: 0.0,
                        offset: Offset(2, 2),
                      )
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  userTypeBlock(
                      text: '손님', isSelected: appBarLogic.isClient.value),
                  userTypeBlock(
                      text: '사장님', isSelected: !appBarLogic.isClient.value),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget userTypeBlock({
    required String text,
    required bool isSelected,
  }) {
    return Expanded(
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.0),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.white : NadoColor.greyColor,
            ),
            textAlign: TextAlign.center,
          )),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
