import 'package:caregiver_hub/shared/constants/routes.dart';
import 'package:caregiver_hub/shared/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum ActionType {
  caregiverFilter,
  caregiverList,
  invert,
  jobList,
}

class InvalidActionTypeException implements Exception {
  final ActionType actionType;
  const InvalidActionTypeException({required this.actionType});
}

class AppBarPopupMenuButton extends StatelessWidget {
  const AppBarPopupMenuButton({Key? key}) : super(key: key);

  void _onSelected(BuildContext context, ActionType actionType) {
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
    final inverse = profileProvider.isCaregiver ? 'Empregador' : 'Cuidador';
    return PopupMenuButton(
      onSelected: (value) => _onSelected(context, value as ActionType),
      itemBuilder: (bContext) {
        return [
          PopupMenuItem<ActionType>(
            value: ActionType.invert,
            child: Text('Visão de $inverse'),
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
        ];
      },
    );
  }
}
