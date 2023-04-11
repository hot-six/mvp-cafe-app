import 'package:dio/dio.dart';
import 'package:nado_client_mvp/app/core/utils/api_request.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NadoRequest extends ApiRequest {
  late final host;

  NadoRequest({required url, data}) : super(url: url, data: data) {
    host = dotenv.env['CLIENT_HOST'] ?? '';
  }

  @override
  BaseOptions getOptions() {
    return BaseOptions(
      baseUrl: host,
      connectTimeout: Duration(milliseconds: 5000),
      receiveTimeout: Duration(milliseconds: 3000),
    );
  }
}
