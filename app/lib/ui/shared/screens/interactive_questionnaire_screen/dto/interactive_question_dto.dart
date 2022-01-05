import 'package:caregiver_hub/ui/shared/screens/interactive_questionnaire_screen/dto/interactive_question_option_dto.dart';

class InteractiveQuestionDTO {
  final String text;
  final dynamic key;
  final List<InteractiveQuestionOptionDTO> options;

  InteractiveQuestionDTO({
    required this.text,
    required this.key,
    required this.options,
  });
}
