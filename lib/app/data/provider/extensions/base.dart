import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class NadoProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = dotenv.env['CLIENT_HOST'] ?? '';
    httpClient.maxAuthRetries = 1;
  }

  @override
  Future<Response<T>> get<T>(
    String url, {
    Map<String, String>? headers,
    String? contentType,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
  }) {
    return super.get(url,
        headers: headers,
        contentType: contentType,
        query: query,
        decoder: decoder == null
            ? null
            : (data) {
                return _customDecoderForErrorHandle<T>(
                  data: data,
                  url: url,
                  decoder: decoder,
                );
              });
  }

  @override
  Future<Response<T>> post<T>(
    String? url,
    dynamic body, {
    Map<String, String>? headers,
    String? contentType,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
    Progress? uploadProgress,
  }) {
    return super.post(
      url,
      body,
      headers: headers,
      contentType: contentType,
      query: query,
      decoder: decoder == null
          ? null
          : (data) {
              return _customDecoderForErrorHandle<T>(
                data: data,
                url: url ?? '',
                decoder: decoder,
                body: body,
              );
            },
      uploadProgress: uploadProgress,
    );
  }

  dynamic _customDecoderForErrorHandle<T>({
    required dynamic data,
    required String url,
    required Function decoder,
    dynamic body,
  }) {
    var returnValue;
    try {
      returnValue = decoder(data);
    } catch (error) {
      error.printError();
    }
    return returnValue;
  }
}
