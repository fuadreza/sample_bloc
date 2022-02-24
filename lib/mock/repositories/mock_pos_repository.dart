
import 'package:sample_bloc/core/network/exceptions/server_exception.dart';
import 'package:sample_bloc/feature/main/data/repositories/pos_repository_impl.dart';
import 'package:sample_bloc/feature/main/data/sources/remote/pos_remote_data_source.dart';
import 'package:sample_bloc/feature/main/domain/entities/location/response/location_response.dart';
import 'package:sample_bloc/feature/main/domain/entities/login/param/login_param.dart';

class MockPosRepository implements PosRepositoryImpl {
  @override
  Future<List<LocationResponse>> getLocations() async {
    // TODO: implement getLocations
    throw UnimplementedError();
  }

  @override
  Future<void> loginUser(LoginParam loginParam) async {
    if(loginParam.password.isNotEmpty) {
      print('success');
    } else {
      throw ServerException(message: 'Error');
    }
  }

  @override
  // TODO: implement remoteDataSource
  PosRemoteDataSource get remoteDataSource => throw UnimplementedError();

}