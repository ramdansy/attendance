import 'package:flutter/material.dart';
import 'package:project_attendance/core/utils/location_service_helper.dart';
import 'package:project_attendance/presentation/pages/location/location_pages.dart';
import '../../../core/app_constant.dart';
import '../../../core/common/common_button.dart';
import '../../../core/common/common_text.dart';

class BottomSheetLocation extends StatelessWidget {
  const BottomSheetLocation({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: AppConstant.paddingSmall),
          width: MediaQuery.of(context).size.width / 3,
          child: const Divider(color: Color(0xFFE2E2E2), thickness: 4),
        ),
        Padding(
          padding: const EdgeInsets.all(AppConstant.paddingNormal),
          child: Column(
            children: [
              Image.asset('assets/animations/animation-location.gif', width: 200, height: 200),
              const SizedBox(height: AppConstant.paddingSmall),
              Text(
                'Fitur ini memerlukan akses ke lokasi Anda. ',
                textAlign: TextAlign.center,
                style: CommonText.fHeading5,
              ),
              Text(
                'Kami mendeteksi bahwa layanan GPS Anda saat ini dinonaktifkan. Untuk melanjutkan, harap aktifkan GPS di pengaturan perangkat Anda',
                textAlign: TextAlign.center,
                style: CommonText.fBodyLarge,
              ),
              const SizedBox(height: AppConstant.paddingLarge),
              Row(
                children: [
                  Expanded(
                      child: CommonButtonOutlined(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          text: 'Back')),
                  const SizedBox(width: AppConstant.paddingNormal),
                  Expanded(
                      child: CommonButtonFilled(
                          onPressed: () async {
                            final enablingServiceLocation = await LocationServiceHelper.openLocationSettings();

                            if (enablingServiceLocation) {
                              Navigator.of(context).pop();
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const LocationPages()),
                              );
                            }
                          },
                          text: 'Aktifkan GPS')),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
