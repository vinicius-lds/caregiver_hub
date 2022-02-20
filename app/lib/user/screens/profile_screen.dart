import 'package:caregiver_hub/main.dart';
import 'package:caregiver_hub/shared/providers/profile_provider.dart';
import 'package:caregiver_hub/shared/widgets/error_state.dart';
import 'package:caregiver_hub/shared/widgets/loading.dart';
import 'package:caregiver_hub/shared/models/user_form_data.dart';
import 'package:caregiver_hub/shared/services/user_service.dart';
import 'package:caregiver_hub/user/widgets/profile_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  final _userService = getIt<UserService>();

  ProfileScreen({Key? key}) : super(key: key);

  Widget _buildBody(BuildContext context, {required bool isEdit}) {
    if (isEdit) {
      final profileProvider = Provider.of<ProfileProvider>(context);
      return StreamBuilder(
        stream: _userService.fetchUserFormData(profileProvider.id),
        builder: (bContext, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Loading();
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return const ErrorState(
              text: 'Ocorreu um erro ao carregar os dados do perfil',
            );
          }
          return ProfileForm(
            data: snapshot.data as UserFormData,
          );
        },
      );
    } else {
      return const ProfileForm();
    }
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
    final isEdit = args['isEdit'] as bool;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Editar perfil' : 'Criar conta'),
      ),
      body: _buildBody(context, isEdit: isEdit),
    );
  }
}
