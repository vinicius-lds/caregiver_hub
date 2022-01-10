import 'package:caregiver_hub/shared/constants/routes.dart';
import 'package:flutter/material.dart';

enum ActionType {
  caregiverFilter,
  caregiverList,
  jobList,
}

class InvalidActionTypeException implements Exception {
  final ActionType actionType;
  const InvalidActionTypeException({required this.actionType});
}

class AppBarPopupMenuButton extends StatelessWidget {
  const AppBarPopupMenuButton({Key? key}) : super(key: key);

  void _onSelected(BuildContext context, ActionType actionType) {
    switch (actionType) {
      case ActionType.caregiverFilter:
        Navigator.of(context).pushNamed(Routes.caregiverFilter);
        break;
      case ActionType.caregiverList:
        Navigator.of(context).pushNamed(Routes.caregiverList);
        break;
      case ActionType.jobList:
        Navigator.of(context).pushNamed(Routes.jobList);
        break;
      default:
        throw InvalidActionTypeException(actionType: actionType);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (value) => _onSelected(context, value as ActionType),
      itemBuilder: (bContext) {
        return [
          const PopupMenuItem<ActionType>(
            value: ActionType.caregiverFilter,
            child: Text('Filtro'),
          ),
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
