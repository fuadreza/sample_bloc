
import 'package:sample_bloc/core/usecase/usecase.dart';
import 'package:sample_bloc/feature/main/domain/entities/location/response/location_response.dart';
import 'package:sample_bloc/feature/main/domain/repositories/pos_repository.dart';

class GetLocationsUseCase implements UseCase<NoParams, List<LocationResponse>> {
  final PosRepository repository;

  GetLocationsUseCase({required this.repository});

  @override
  Future<List<LocationResponse>> invoke(NoParams params) async {
    return await repository.getLocations();
  }

}
