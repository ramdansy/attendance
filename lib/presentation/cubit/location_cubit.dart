import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:project_attendance/core/utils/location_service_helper.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());

  Position? position;

  void initLocation() async {
    position = await LocationServiceHelper().getCurrentLocation();

    if (position != null) {
      emit(CurrenLocationLoaded(position: position!));
    } else {
      emit(CurrentLocationFailed());
    }
  }
}
