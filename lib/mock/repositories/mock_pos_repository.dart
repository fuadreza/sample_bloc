
import 'package:sample_bloc/core/network/exceptions/server_exception.dart';
import 'package:sample_bloc/feature/main/data/repositories/pos_repository_impl.dart';
import 'package:sample_bloc/feature/main/data/sources/remote/pos_remote_data_source.dart';
import 'package:sample_bloc/feature/main/domain/entities/location/response/location_response.dart';
import 'package:sample_bloc/feature/main/domain/entities/login/param/login_param.dart';

class MockPosRepository implements PosRepositoryImpl {

  final List<LocationResponse> locations = [
    LocationResponse(locationId: 1, locationName: 'Location 1', address: 'Address 1', city: 'City 1', phone: 'Phone 1', email: 'Email 1'),
    LocationResponse(locationId: 2, locationName: 'Location 2', address: 'Address 2', city: 'City 2', phone: 'Phone 2', email: 'Email 2'),
    LocationResponse(locationId: 3, locationName: 'Location 3', address: 'Address 3', city: 'City 3', phone: 'Phone 3', email: 'Email 3')
  ];

  @override
  Future<List<LocationResponse>> getLocations() async {
    return locations;
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