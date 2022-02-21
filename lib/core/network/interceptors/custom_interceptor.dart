
import 'package:dio/dio.dart';
import 'package:sample_bloc/core/services/hive_service.dart';

class CustomInterceptors extends Interceptor {
  CustomInterceptors();

  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
  ) async {
    String? token = await hive.getToken();
    // options.headers['Accept'] = '*/*';
    print('TOKEN => $token');

    if (token != null) options.headers['Authorization'] = token;

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('RES > $response');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    print('Error > $err');
    //TODO HANDLE REFRESH TOKEN
    super.onError(err, handler);
  }
}
