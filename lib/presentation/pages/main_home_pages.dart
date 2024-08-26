import 'package:flutter/material.dart';
import 'package:project_attendance/core/utils/location_service_helper.dart';
import 'package:project_attendance/presentation/pages/location/bottomsheet_location_widget.dart';
import 'package:project_attendance/presentation/pages/location/location_pages.dart';

class MainHomePages extends StatelessWidget {
  const MainHomePages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Home'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final serviceEnabled = await LocationServiceHelper.checkLocationService();

            if (!serviceEnabled) {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.white,
                builder: (context) => BottomSheetLocation(context: context),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LocationPages()),
              );
            }
          },
          child: Text('Goto Location'),
        ),
      ),
    );
  }
}
