

import 'package:equatable/equatable.dart';
import 'package:sample_bloc/feature/main/domain/entities/location/response/location_response.dart';

class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object?> get props => [];
}

class LocationInit extends LocationState {}

class LocationLoading extends LocationState {}

class LocationSuccess extends LocationState {
  final List<LocationResponse> locations;

  const LocationSuccess({
    required this.locations,
  });
}

class LocationFailed extends LocationState {
  final String message;

  const LocationFailed({
    required this.message,
  });
}