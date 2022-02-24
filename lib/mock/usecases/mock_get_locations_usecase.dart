
import 'package:sample_bloc/core/usecase/usecase.dart';
import 'package:sample_bloc/feature/main/domain/entities/location/response/location_response.dart';
import 'package:sample_bloc/feature/main/domain/repositories/pos_repository.dart';
import 'package:sample_bloc/feature/main/domain/usecases/get_locations_usecase.dart';
import 'package:sample_bloc/mock/repositories/mock_pos_repository.dart';

class MockGetLocationsUseCase implements GetLocationsUseCase {

  @override
  PosRepository get repository => MockPosRepository();

  @override
  Future<List<LocationResponse>> invoke(NoParams params) async {
    return await repository.getLocations();
  }

}