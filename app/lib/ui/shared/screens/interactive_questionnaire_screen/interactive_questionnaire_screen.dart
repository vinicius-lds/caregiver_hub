import 'dart:io';

import 'package:caregiver_hub/ui/shared/exceptions/not_implemented_exception.dart';
import 'package:caregiver_hub/ui/shared/screens/interactive_questionnaire_screen/dto/interactive_question_dto.dart';
import 'package:caregiver_hub/ui/shared/screens/interactive_questionnaire_screen/interactive_questionnaire_screen_mat.dart';
import 'package:flutter/widgets.dart';

class InteractiveQuestionnaireScreen extends StatelessWidget {
  final List<InteractiveQuestionDTO> questions;
  final void Function(Map<dynamic, dynamic>) onFinised;

  const InteractiveQuestionnaireScreen({
    Key? key,
    required this.questions,
    required this.onFinised,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return InteractiveQuestionnaireScreenMat(
        questions: questions,
        onFinised: onFinised,
      );
    }
    throw NotImplementedException('InteractiveQuestionnaireScreen');
  }
}
