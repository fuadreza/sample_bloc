
import 'package:sample_bloc/feature/main/domain/entities/location/response/location_response.dart';
import 'package:sample_bloc/feature/main/domain/entities/login/param/login_param.dart';

abstract class PosRepository {

  Future<void> loginUser(LoginParam loginParam);

  Future<List<LocationResponse>> getLocations();

}