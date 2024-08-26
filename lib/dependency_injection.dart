import 'package:get_it/get_it.dart';

import 'presentation/cubit/location_cubit.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // Data sources

  // Repositories

  // Use cases

  // Blocs
  getIt.registerFactory(() => LocationCubit());
}
