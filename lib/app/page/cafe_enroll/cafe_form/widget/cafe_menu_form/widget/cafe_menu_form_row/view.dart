import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nado_client_mvp/app/core/values/colors.dart';
import 'package:nado_client_mvp/app/data/model/menu.dart';
import 'package:nado_client_mvp/app/global_widgets/input.dart';
import 'package:nado_client_mvp/app/page/cafe_enroll/cafe_form/widget/cafe_menu_form/widget/cafe_menu_form_row/logic.dart';

class CafeMenuFormRow extends StatelessWidget {
  final int rowIndex;
  final Menu cafeMenu;
  final CafeMenuFormRowLogic logic;

  CafeMenuFormRow({
    required this.rowIndex,
    required this.cafeMenu,
  }) : logic = Get.put(CafeMenuFormRowLogic(cafeMenu: cafeMenu),
            tag: 'cafe_menu_form_row_${rowIndex}');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Obx(
              () => InkWell(
                onTap: logic.onTapSignatureSign,
                child: logic.isSignature.value
                    ? Image.asset('assets/images/check_filled_primary.png')
                    : Image.asset('assets/images/check_filled.png'),
              ),
            ),
            SizedBox(width: 13.0),
            Expanded(
              child: SquareInputField(
                  textEditingController: logic.menuNameController,
                  hintText: '메뉴명',
                  onChange: (string) {
                    logic.cafeMenu.name = string;
                  }),
            ),
            SizedBox(width: 13.0),
            Expanded(
              child: SquareInputField(
                textEditingController: logic.menuPriceController,
                keyboardType: TextInputType.number,
                suffix: Text('원'),
                onChange: (string) {
                  int? parseValue = int.tryParse(string);
                  if (parseValue != null) logic.cafeMenu.price = parseValue;
                },
              ),
            ),
            SizedBox(width: 13.0),
            InkWell(
              onTap: () {
                logic.onDeleteCafeMenu(rowIndex);
              },
              child: Icon(
                Icons.remove_circle,
                color: NadoColor.greyColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
      ],
    );
  }
}
