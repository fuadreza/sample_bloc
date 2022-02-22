
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_bloc/core/network/exceptions/server_exception.dart';
import 'package:sample_bloc/core/usecase/usecase.dart';
import 'package:sample_bloc/feature/main/domain/entities/location/state/location_state.dart';
import 'package:sample_bloc/feature/main/domain/usecases/get_locations_usecase.dart';

class HomeCubit extends Cubit<LocationState> {
  final GetLocationsUseCase getLocationsUseCase;

  HomeCubit({
    required this.getLocationsUseCase,
  }): super(LocationInit());

  getLocations() async {
    emit(LocationLoading());
    try {
      final locations = await getLocationsUseCase.invoke(NoParams());
      emit(LocationSuccess(locations: locations));
    } on ServerException catch (error) {
      emit(LocationFailed(message: '${error.message}'));
    }
  }
}