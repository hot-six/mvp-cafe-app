import 'package:get/get.dart';
import 'package:nado_client_mvp/app/data/model/cafe.dart';
import 'package:nado_client_mvp/app/data/model/paginatedResponse.dart';
import 'package:nado_client_mvp/app/data/provider/extensions/base.dart';

extension CafeProviderEx on NadoProvider {
  Future<Response<PaginatedResponse<CafeTile>?>> getCafeList({
    required List<String> filterTypes,
    required int pageKey,
  }) {
    Map<String, dynamic> queryParams = {
      'page': '$pageKey',
      'filterTypes': filterTypes,
    };

    String queryString = Uri(queryParameters: queryParams).query;

    return get('/api/v1/cafe/list?$queryString', decoder: (data) {
      try {
        var responseData = data['data'];
        var responseContent = responseData['content'];

        if (responseData != null && responseContent != null) {
          List<CafeTile> severSearchedCafe = (responseContent as List)
              .map((e) => CafeTile.fromJson(e))
              .toList();

          return PaginatedResponse.parse(
              contents: severSearchedCafe, json: responseData);
        } else {
          printInfo(info: 'Failed to get Cafe List');
          return PaginatedResponse.empty();
        }
      } on Exception catch (error) {
        error.printError();
        return PaginatedResponse.empty();
      }
    });
  }

  Future<Response<CafeDetail?>> getCafeDetailData({
    required String cafeId,
    required List<String> filterTypes,
  }) {
    Map<String, dynamic> queryParams = {
      'cafeId': '$cafeId',
      'filterTypes': filterTypes,
    };

    String queryString = Uri(queryParameters: queryParams).query;

    return get('/api/v1/cafe/detail/?$queryString', decoder: (data) {
      try {
        if (data['data'] != null) {
          return CafeDetail.fromJson(data['data']);
        } else {
          printError(info: 'Failed to get cafe detail data');
          return null;
        }
      } on Exception catch (error) {
        error.printError();
        return null;
      }
    });
  }

  Future<Response<PaginatedResponse<CafeTile>?>> getFavoriteCafeList({
    required List<int> favoriteCafeIdList,
    required int pageKey,
  }) {
    Map<String, dynamic> queryParams = {
      'page': '$pageKey',
      'cafeIds': favoriteCafeIdList.map((e) => e.toString()).toList(),
    };

    String queryString = Uri(queryParameters: queryParams).query;

    return get(
      '/api/v1/cafe/favorite?$queryString',
      decoder: (data) {
        try {
          var responseData = data['data'];
          var responseContent = data['data']['content'];

          if (responseData != null && responseContent != null) {
            List<CafeTile> serverFavoriteCafeList =
                (responseContent as List).map((cafeTile) {
              return CafeTile.fromJson(cafeTile);
            }).toList();

            return PaginatedResponse.parse(
                contents: serverFavoriteCafeList, json: responseData);
          } else {
            printInfo(info: 'Failed to get favorite cafe list');
            return PaginatedResponse.empty();
          }
        } on Exception catch (error) {
          error.printError();
          return PaginatedResponse.empty();
        }
      },
    );
  }
}
