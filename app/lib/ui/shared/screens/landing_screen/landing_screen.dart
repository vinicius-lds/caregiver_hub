import 'package:caregiver_hub/ui/shared/constants/routes.dart';
import 'package:caregiver_hub/ui/shared/screens/interactive_questionnaire_screen/dto/interactive_question_dto.dart';
import 'package:caregiver_hub/ui/shared/screens/interactive_questionnaire_screen/dto/interactive_question_option_dto.dart';
import 'package:caregiver_hub/ui/shared/screens/interactive_questionnaire_screen/interactive_questionnaire_screen.dart';
import 'package:flutter/widgets.dart';

enum Questions {
  iAm,
  iWantTo,
}

enum Question1Options {
  employer,
  caregiver,
}

enum Question2Options {
  login,
  signup,
}

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  void _onFinished(BuildContext context, Map<dynamic, dynamic> result) {
    if (result[Questions.iAm] == Question1Options.caregiver &&
        result[Questions.iWantTo] == Question2Options.login) {
      Navigator.pushNamed(context, Routes.LOGIN_SCREEN, arguments: {});
    } else if (result[Questions.iAm] == Question1Options.caregiver &&
        result[Questions.iWantTo] == Question2Options.signup) {
      Navigator.pushNamed(context, Routes.CAREGIVER_SIGNUP_SCREEN);
    } else if (result[Questions.iAm] == Question1Options.employer &&
        result[Questions.iWantTo] == Question2Options.login) {
      Navigator.pushNamed(context, Routes.LOGIN_SCREEN, arguments: {});
    } else if (result[Questions.iAm] == Question1Options.employer &&
        result[Questions.iWantTo] == Question2Options.signup) {
      Navigator.pushNamed(context, Routes.EMPLOYER_SIGNUP_SCREEN);
    } else {
      Navigator.pushNamed(context, Routes.LANDING_SCREEN);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InteractiveQuestionnaireScreen(
      questions: [
        InteractiveQuestionDTO(
          text: 'EU SOU UM...',
          key: Questions.iAm,
          options: [
            InteractiveQuestionOptionDTO(
              text: 'EMPREGADOR',
              value: Question1Options.employer,
            ),
            InteractiveQuestionOptionDTO(
              text: 'CUIDADOR',
              value: Question1Options.caregiver,
            ),
          ],
        ),
        InteractiveQuestionDTO(
          text: 'EU QUERO...',
          key: Questions.iWantTo,
          options: [
            InteractiveQuestionOptionDTO(
              text: 'ENTRAR',
              value: Question2Options.login,
            ),
            InteractiveQuestionOptionDTO(
              text: 'CRIAR UMA CONTA',
              value: Question2Options.signup,
            ),
          ],
        ),
      ],
      onFinised: (result) => _onFinished(context, result),
    );
  }
}
