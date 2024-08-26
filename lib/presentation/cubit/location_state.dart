part of 'location_cubit.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

class LocationInitial extends LocationState {}

class CurrenLocationLoaded extends LocationState {
  final Position position;

  const CurrenLocationLoaded({required this.position});
}

class CurrentLocationFailed extends LocationState {}
