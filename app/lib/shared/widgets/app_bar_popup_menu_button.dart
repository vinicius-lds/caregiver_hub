import 'package:caregiver_hub/main.dart';
import 'package:caregiver_hub/shared/constants/routes.dart';
import 'package:caregiver_hub/shared/providers/profile_provider.dart';
import 'package:caregiver_hub/shared/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum ActionType {
  caregiverFilter,
  caregiverList,
  caregiverProfile,
  invert,
  jobList,
  logout,
  profile,
}

class InvalidActionTypeException implements Exception {
  final ActionType actionType;
  const InvalidActionTypeException({required this.actionType});
}

class AppBarPopupMenuButton extends StatelessWidget {
  final _authService = getIt<AuthService>();

  AppBarPopupMenuButton({Key? key}) : super(key: key);

  void _onSelected(BuildContext context, ActionType actionType) async {
    if (actionType == ActionType.invert) {
      final profileProvider =
          Provider.of<ProfileProvider>(context, listen: false);
      profileProvider.isCaregiver = !profileProvider.isCaregiver;
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/',
        (route) => false, // Remove todas as telas do stack
      );
      return;
    }
    if (actionType == ActionType.profile) {
      Navigator.of(context)
          .pushNamed(Routes.profile, arguments: {'isEdit': true});
      return;
    }
    if (actionType == ActionType.caregiverProfile) {
      Navigator.of(context).pushNamed(Routes.caregiverForm);
      return;
    }
    if (actionType == ActionType.logout) {
      await _authService.logout();
      Provider.of<ProfileProvider>(context).id = '';
      Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.landing,
        (route) => false, // Remove todas as telas do stack
      );
      return;
    }
    String newRouteName;
    switch (actionType) {
      case ActionType.caregiverFilter:
        newRouteName = Routes.caregiverFilter;
        break;
      case ActionType.caregiverList:
        newRouteName = Routes.caregiverList;
        break;
      case ActionType.jobList:
        newRouteName = Routes.jobList;
        break;
      default:
        throw InvalidActionTypeException(actionType: actionType);
    }
    Navigator.of(context).pushNamedAndRemoveUntil(
      newRouteName,
      (route) => false, // Remove todas as telas do stack
    );
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final inverse = profileProvider.isCaregiver ? 'empregador' : 'cuidador';
    return PopupMenuButton(
      onSelected: (value) => _onSelected(context, value as ActionType),
      itemBuilder: (bContext) {
        return [
          PopupMenuItem<ActionType>(
            value: ActionType.invert,
            child: Text('Visão de $inverse'),
          ),
          const PopupMenuItem<ActionType>(
            value: ActionType.profile,
            child: Text('Perfil'),
          ),
          if (profileProvider.isCaregiver)
            const PopupMenuItem<ActionType>(
              value: ActionType.caregiverProfile,
              child: Text('Perfil de cuidador'),
            ),
          if (!profileProvider.isCaregiver)
            const PopupMenuItem<ActionType>(
              value: ActionType.caregiverFilter,
              child: Text('Filtro'),
            ),
          if (!profileProvider.isCaregiver)
            const PopupMenuItem<ActionType>(
              value: ActionType.caregiverList,
              child: Text('Cuidadores'),
            ),
          const PopupMenuItem<ActionType>(
            value: ActionType.jobList,
            child: Text('Trabalhos'),
          ),
          const PopupMenuItem<ActionType>(
            value: ActionType.logout,
            child: Text('Sair'),
          ),
        ];
      },
    );
  }
}
