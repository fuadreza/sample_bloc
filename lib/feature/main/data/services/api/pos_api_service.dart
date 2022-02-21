
import 'package:sample_bloc/core/network/base_api_client.dart';
import 'package:sample_bloc/feature/main/domain/entities/login/param/login_param.dart';

import 'pos_api_url.dart';

class PosApiService {
  final BaseApiClient apiClient;

  PosApiService({required this.apiClient});

  Future<String> loginUser(LoginParam loginParam) {
    final Map<String, dynamic> jsonBody = <String, dynamic> {
      'email': loginParam.email,
      'password': loginParam.password
    };

    return apiClient.post(pathUrl: PosApiUrl.URL_LOGIN, jsonBody: jsonBody);
  }

  Future<String> getLocations(String pageSize) {
    final String path = '?pageSize=$pageSize';

    return apiClient.get(pathUrl: PosApiUrl.URL_LOCATIONS, path: path);
  }
}