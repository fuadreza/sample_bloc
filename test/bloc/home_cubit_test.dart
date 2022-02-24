
import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sample_bloc/feature/main/domain/entities/location/response/location_response.dart';
import 'package:sample_bloc/feature/main/domain/entities/location/state/location_state.dart';
import 'package:sample_bloc/feature/main/presentation/modules/home/home_cubit.dart';
import 'package:sample_bloc/mock/usecases/mock_get_locations_usecase.dart';

void main() {
  group('Home Cubit', () {
    late HomeCubit homeCubit;
    MockGetLocationsUseCase mockGetLocationsUseCase;

    setUp(() {
      EquatableConfig.stringify = true;
      mockGetLocationsUseCase = MockGetLocationsUseCase();
      homeCubit = HomeCubit(getLocationsUseCase: mockGetLocationsUseCase);
    });

    blocTest<HomeCubit, LocationState>(
      'emits [LocationLoading, LocationSuccess] states for successful get locations',
      build: () => homeCubit,
      act: (cubit) => cubit.getLocations(),
      expect: () => [
        LocationLoading(),
        const LocationSuccess(locations: [
          LocationResponse(locationId: 1, locationName: 'Location 1', address: 'Address 1', city: 'City 1', phone: 'Phone 1', email: 'Email 1'),
          LocationResponse(locationId: 2, locationName: 'Location 2', address: 'Address 2', city: 'City 2', phone: 'Phone 2', email: 'Email 2'),
          LocationResponse(locationId: 3, locationName: 'Location 3', address: 'Address 3', city: 'City 3', phone: 'Phone 3', email: 'Email 3')
        ]),
      ],
    );

    tearDown(() {
      homeCubit.close();
    });
  });
}