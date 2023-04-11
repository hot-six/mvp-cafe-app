import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nado_client_mvp/app/global_widgets/loading_indicator.dart';
import 'package:nado_client_mvp/app/page/client/widget/cafe_list_tile/view.dart';
import 'package:nado_client_mvp/app/global_widgets/appbar/view.dart';

import 'logic.dart';

class CeoPage extends StatelessWidget {
  final CeoPageLogic logic = Get.put(CeoPageLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NadoAppBar(),
      body: Obx(
        () => logic.isLoaded.value
            ? Stack(
                children: [
                  NaverMap(
                    initLocationTrackingMode: LocationTrackingMode.Follow,
                    onMapCreated: logic.onMapCreated,
                    mapType: MapType.Basic,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        logic.ceoCafeDetail.latitude,
                        logic.ceoCafeDetail.longitude,
                      ),
                    ),
                    markers: logic.mapMarkerList,
                  ),
                  Column(
                    children: [
                      Spacer(),
                      _cafeList(),
                    ],
                  ),
                ],
              )
            : Center(child: LoadingIndicator()),
      ),
    );
  }

  Widget _cafeList() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 25.0,
      ),
      decoration: BoxDecoration(
        color: HexColor('#ffffff'),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.0),
          topRight: Radius.circular(32.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.15),
            blurRadius: 24.0,
            spreadRadius: 0.0,
            offset: Offset(0, -8),
          )
        ],
      ),
      child: CafeListTile(
        cafeTileData: logic.ceoCafeTile,
        initFavoriteState: false,
      ),
    );
  }
}
