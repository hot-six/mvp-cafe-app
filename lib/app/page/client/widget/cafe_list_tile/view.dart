import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nado_client_mvp/app/core/values/colors.dart';
import 'package:nado_client_mvp/app/core/values/theme.dart';
import 'package:nado_client_mvp/app/data/model/cafe.dart';
import 'package:nado_client_mvp/app/global_widgets/dialog/accuracy_dialog.dart';
import 'package:nado_client_mvp/app/global_widgets/type_chip.dart';
import 'package:nado_client_mvp/app/page/client/widget/cafe_list_tile/logic.dart';

class CafeListTile extends StatelessWidget {
  final CafeTile cafeTileData;
  final bool initFavoriteState;
  final CafeListTileLogic logic;

  CafeListTile({required this.cafeTileData, required this.initFavoriteState})
      : logic = Get.put(
            CafeListTileLogic(
                cafeTileData: cafeTileData,
                initFavoriteState: initFavoriteState),
            tag: 'cafe_tile_${cafeTileData.id}');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: logic.onTapTile,
          child: Container(
            padding: EdgeInsets.all(12.0),
            height: 174.0,
            decoration: BoxDecoration(
              color: NadoColor.greyColor[100],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: [
                SizedBox(
                  height: 150.0,
                  width: 150.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: cafeTileData.thumbnail != null
                        ? Image.memory(
                            Base64Codec()
                                .decode(cafeTileData.thumbnail!.imageUrl),
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/images/no_list_image.png',
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(right: 15.0),
                              child: Text(
                                '${cafeTileData.cafeName}',
                                style: appTextTheme.headlineSmall,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          if (cafeTileData.accuracy > 0)
                            InkWell(
                              onTap: () {
                                Get.dialog(CafeAccuracyDialog());
                              },
                              child: Image.asset(
                                'assets/images/accuracy_${logic.tileAccuracy}.png',
                                width: 13.0,
                              ),
                            ),
                        ],
                      ),
                      Spacer(),
                      Text(
                        '${cafeTileData.cafeAddress}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(fontSize: 12.0),
                      ),
                      Spacer(),
                      Wrap(
                        spacing: 3.0,
                        runSpacing: 3.0,
                        children: List.generate(
                          cafeTileData.cafeTypes.length,
                          (index) => SmallGreyCafeTypeChip(
                            cafeType:
                                '${cafeTileData.cafeTypes[index].typeName}',
                          ),
                        ),
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${cafeTileData.openType.displayName}',
                            style: appTextTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: NadoColor.primary,
                            ),
                          ),
                          Obx(
                            () => InkWell(
                              onTap: logic.onTapFavoriteCafeToggle,
                              child: logic.isFavorite.value
                                  ? Image.asset(
                                      'assets/images/heart_fill.png',
                                      color: NadoColor.primary,
                                      width: 20.0,
                                    )
                                  : Image.asset(
                                      'assets/images/heart.png',
                                      color: NadoColor.primary,
                                      width: 20.0,
                                    ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10.0)
      ],
    );
  }
}
