import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nado_client_mvp/app/core/values/colors.dart';
import 'package:nado_client_mvp/app/data/model/menu.dart';
import 'package:nado_client_mvp/app/page/cafe_enroll/cafe_form/widget/cafe_menu_form/logic.dart';
import 'package:nado_client_mvp/app/page/cafe_enroll/cafe_form/widget/cafe_menu_form/widget/cafe_menu_form_row/view.dart';

class CafeMenuForm extends StatelessWidget {
  final RxList<Menu> cafeMenuList;
  final CafeMenuFormLogic logic;

  CafeMenuForm({required this.cafeMenuList})
      : logic = Get.put(CafeMenuFormLogic(cafeMenuList: cafeMenuList));

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Text(
                '카페 메뉴와 가격을 입력해 주세요',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                '시그니처 메뉴일 경우 왼쪽의 체크박스를 눌러주세요.',
                style: TextStyle(
                  fontSize: 12.0,
                  color: NadoColor.greyColor[400],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.0),
        _cafeMenuCreator(),
      ],
    );
  }

  Widget _cafeMenuCreator() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
      color: NadoColor.greyColor[100],
      child: Obx(
        () => Column(
          children: [
            _cafeMenuHeader(),
            ...List.generate(
              logic.cafeMenuList.length,
              (index) => CafeMenuFormRow(
                rowIndex: index,
                cafeMenu: logic.cafeMenuList[index],
              ),
            ),
            InkWell(
              onTap: logic.addNewMenu,
              child: Container(
                padding: EdgeInsets.only(top: 16.0),
                child: Image.asset('assets/images/add.png'),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _cafeMenuHeader() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/images/cup.png',
              color: NadoColor.greyColor,
              width: 21.0,
              height: 21.0,
            ),
            SizedBox(width: 13.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '메뉴',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            Spacer(),
            SizedBox(width: 13.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '가격',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            Spacer(),
          ],
        ),
        SizedBox(
          height: 8.0,
        ),
      ],
    );
  }
}
