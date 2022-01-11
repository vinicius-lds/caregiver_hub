import 'package:caregiver_hub/employer/models/caregiver_recomendation_form_data.dart';
import 'package:caregiver_hub/employer/providers/caregiver_recomendation_provider.dart';
import 'package:caregiver_hub/employer/widgets/caregiver_recomendation_form.dart';
import 'package:caregiver_hub/shared/providers/profile_provider.dart';
import 'package:caregiver_hub/shared/widgets/app_bar_popup_menu_button.dart';
import 'package:caregiver_hub/shared/widgets/error_state.dart';
import 'package:caregiver_hub/shared/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CaregiverRecomendationScreen extends StatelessWidget {
  const CaregiverRecomendationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
    final caregiverRecomendationProvider =
        Provider.of<CaregiverRecomendationProvider>(context);
    final profileProvider = Provider.of<ProfileProvider>(context);
    final caregiverId = args['caregiverId'] as String;
    return Scaffold(
      appBar: AppBar(
        title: const Text('CaregiverHub'),
        actions: const [
          AppBarPopupMenuButton(),
        ],
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<CaregiverRecomendationFormData>(
          stream: caregiverRecomendationProvider.formDataStream(
            caregiverId: caregiverId,
            employerId: profileProvider.id,
          ),
          builder: (bContext, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Loading();
            }
            if (!snapshot.hasData || snapshot.data == null) {
              return const ErrorState(text: 'Ocorreu um erro inesperado');
            }
            final data = snapshot.data as CaregiverRecomendationFormData;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: CaregiverRecomendationForm(data: data),
            );
          },
        ),
      ),
    );
  }
}
