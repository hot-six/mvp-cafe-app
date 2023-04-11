import 'package:dio/dio.dart';

class ApiRequest {
  final String url;
  final Map<String, dynamic>? data;

  ApiRequest({
    required this.url,
    this.data,
  });

  BaseOptions getOptions() {
    return BaseOptions();
  }

  Dio _dio() {
    var options = this.getOptions();
    return Dio(options);
  }

  void get({
    Function()? beforeSend,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  }) {
    if (beforeSend != null) beforeSend();

    _dio().get(this.url, queryParameters: this.data).then((res) {
      if (onSuccess != null) onSuccess(res.data);
    }).catchError((error) {
      if (onError != null) onError(error);
    });
  }

  void post({
    Function()? beforeSend,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  }) {
    if (beforeSend != null) beforeSend();

    _dio().post(this.url, queryParameters: this.data).then((res) {
      if (onSuccess != null) onSuccess(res.data);
    }).catchError((error) {
      if (onError != null) onError(error);
    });
  }
}
