import 'package:caregiver_hub/main.dart';
import 'package:caregiver_hub/shared/providers/profile_provider.dart';
import 'package:caregiver_hub/shared/widgets/error_state.dart';
import 'package:caregiver_hub/shared/widgets/loading.dart';
import 'package:caregiver_hub/user/models/caregiver_form_data.dart';
import 'package:caregiver_hub/user/services/user_service.dart';
import 'package:caregiver_hub/user/widgets/caregiver_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CaregiverFormScreen extends StatelessWidget {
  final _userService = getIt<UserService>();

  CaregiverFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil de cuidador'),
      ),
      body: StreamBuilder(
        stream: _userService.fetchCaregiverFormData(profileProvider.id),
        builder: (bContext, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Loading();
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return const ErrorState(
              text: 'Ocorreu um erro ao carregar os dados do perfil',
            );
          }
          final data = snapshot.data as CaregiverFormData;
          return Padding(
            padding: const EdgeInsets.all(10),
            child: CaregiverForm(data: data),
          );
        },
      ),
    );
  }
}
