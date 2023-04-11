import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:nado_client_mvp/app/data/model/cafe.dart';

class Storage {
  static final Storage _singleton = Storage._internal();

  factory Storage() {
    return _singleton;
  }

  Storage._internal();

  dynamic __read(String key) async {
    if (GetPlatform.isWeb) {
      // return window.localStorage[key];
    } else {
      final storage = new FlutterSecureStorage();
      return await storage.read(key: key);
    }
  }

  Future<void> __write(String key, dynamic value) async {
    if (GetPlatform.isWeb) {
      // window.localStorage[key] = value;
    } else {
      final storage = new FlutterSecureStorage();
      await storage.write(key: key, value: value);
    }
  }

  Future<void> __delete(String key) async {
    if (GetPlatform.isWeb) {
      // window.localStorage.remove(key);
    } else {
      final storage = new FlutterSecureStorage();
      await storage.delete(key: key);
    }
  }

  Future<void> deleteAll() async {
    if (GetPlatform.isWeb) {
    } else {
      final storage = new FlutterSecureStorage();
      await storage.deleteAll();
    }
  }

  Future<CafeDetail> getCeoCafeDetail() async {
    final storage = new FlutterSecureStorage();

    var jsonCafeData = await storage.read(key: 'ceoCafeDetail');

    if (jsonCafeData != null) {
      Map<String, dynamic> mapCafeData = json.decode(jsonCafeData);
      CafeDetail cafeData = CafeDetail.fromJson(mapCafeData);

      return cafeData;
    } else {
      return CafeDetail.full();
    }
  }

  Future<CafeTile> getCeoCafeTile() async {
    final storage = new FlutterSecureStorage();

    var jsonCafeTileData = await storage.read(key: 'ceoCafeTile');

    if (jsonCafeTileData != null) {
      Map<String, dynamic> mapCafeData = json.decode(jsonCafeTileData);
      CafeTile cafeData = CafeTile.fromJson(mapCafeData);
      return cafeData;
    } else {
      CafeDetail cafeDetailData = await getCeoCafeDetail();
      return CafeTile(
          id: cafeDetailData.id,
          cafeName: cafeDetailData.cafeName,
          cafeAddress: cafeDetailData.cafeAddress,
          mainSchedule: cafeDetailData.mainSchedule,
          latitude: cafeDetailData.latitude,
          longitude: cafeDetailData.longitude,
          cafeTypes: cafeDetailData.cafeTypes.sublist(0, 3),
          openType: cafeDetailData.openType,
          accuracy: 100.0);
    }
  }

  Future<void> saveCeoCafeDetail({required CafeDetail cafeData}) async {
    final storage = new FlutterSecureStorage();

    var jsonCafeData = cafeData.toJson();

    storage.write(key: 'ceoCafeDetail', value: json.encode(jsonCafeData));
  }

  Future<void> saveCeoCafeTile({required CafeTile cafeData}) async {
    final storage = new FlutterSecureStorage();

    var jsonCafeData = cafeData.toJson();

    storage.write(key: 'ceoCafeTile', value: json.encode(jsonCafeData));
  }

  void addFavoriteCafe({required int cafeId}) async {
    final storage = new FlutterSecureStorage();

    List<int> decodeFavoriteList = await getFavoriteCafe();

    decodeFavoriteList.add(cafeId);

    await storage.write(
        key: 'favorite_cafe', value: jsonEncode(decodeFavoriteList));
  }

  void deleteFavoriteCafe({required int cafeId}) async {
    final storage = new FlutterSecureStorage();

    List<int> decodeFavoriteList = await getFavoriteCafe();

    decodeFavoriteList.remove(cafeId);

    await storage.write(
        key: 'favorite_cafe', value: jsonEncode(decodeFavoriteList));
  }

  Future<List<int>> getFavoriteCafe() async {
    final storage = new FlutterSecureStorage();

    String? jsonFavoriteCafeList = await storage.read(key: 'favorite_cafe');

    if (jsonFavoriteCafeList != null)
      return (jsonDecode(jsonFavoriteCafeList) as List)
          .map((e) => int.parse('$e'))
          .toList();

    return [];
  }
}
