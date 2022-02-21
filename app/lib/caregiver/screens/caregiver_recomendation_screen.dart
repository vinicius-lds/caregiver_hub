import 'package:caregiver_hub/caregiver/models/caregiver_recomendation_form_data.dart';
import 'package:caregiver_hub/caregiver/services/caregiver_recomendation_service.dart';
import 'package:caregiver_hub/caregiver/widgets/caregiver_recomendation_form.dart';
import 'package:caregiver_hub/main.dart';
import 'package:caregiver_hub/shared/models/caregiver_recomendation_user_data.dart';
import 'package:caregiver_hub/shared/providers/app_state_provider.dart';
import 'package:caregiver_hub/shared/services/user_service.dart';
import 'package:caregiver_hub/shared/widgets/error_state.dart';
import 'package:caregiver_hub/shared/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class CaregiverRecomendationScreen extends StatelessWidget {
  final _caregiverRecomendationService = getIt<CaregiverRecomendationService>();
  final _userService = getIt<UserService>();

  CaregiverRecomendationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
    final appStateProvider = Provider.of<AppStateProvider>(context);
    final caregiverId = args['caregiverId'] as String;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recomendar cuidador'),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<List<dynamic>>(
          stream: CombineLatestStream.list([
            _caregiverRecomendationService.fetchCaregiverRecomendationFormData(
              caregiverId: caregiverId,
              employerId: appStateProvider.id,
            ),
            _userService.fetchCaregiverRecomendationUserData(
              userId: appStateProvider.id,
            ),
          ]),
          builder: (bContext, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Loading();
            }
            if (!snapshot.hasData || snapshot.data == null) {
              return const ErrorState(text: 'Ocorreu um erro inesperado');
            }
            final data = snapshot.data as List<dynamic>;
            final caregiverRecomendationFormData =
                data[0] as CaregiverRecomendationFormData;
            final caregiverRecomendationUserData =
                data[1] as CaregiverRecomendationUserData;
            return Padding(
              padding: const EdgeInsets.all(10),
              child: CaregiverRecomendationForm(
                caregiverRecomendationFormData: caregiverRecomendationFormData,
                caregiverRecomendationUserData: caregiverRecomendationUserData,
              ),
            );
          },
        ),
      ),
    );
  }
}
