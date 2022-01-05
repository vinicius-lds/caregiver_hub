import 'package:caregiver_hub/ui/shared/screens/interactive_questionnaire_screen/dto/interactive_question_dto.dart';
import 'package:caregiver_hub/ui/shared/screens/interactive_questionnaire_screen/dto/interactive_question_option_dto.dart';
import 'package:flutter/material.dart';

class InteractiveQuestionnaireScreenMat extends StatefulWidget {
  final List<InteractiveQuestionDTO> questions;
  final void Function(Map<dynamic, dynamic>) onFinised;

  const InteractiveQuestionnaireScreenMat({
    Key? key,
    required this.questions,
    required this.onFinised,
  }) : super(key: key);

  @override
  State<InteractiveQuestionnaireScreenMat> createState() =>
      _InteractiveQuestionnaireScreenMatState();
}

class _InteractiveQuestionnaireScreenMatState
    extends State<InteractiveQuestionnaireScreenMat> {
  int _index = 0;
  final Map<dynamic, dynamic> _result = {};

  void _selectOption(InteractiveQuestionOptionDTO option) {
    setState(() {
      final question = widget.questions[_index];
      _result[question.key] = option.value;
      _index++;
      if (_index >= widget.questions.length) {
        widget.onFinised(_result);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_index < 0 || _index >= widget.questions.length) {
      return const Scaffold(
        body: Text('Erro'),
      );
    }

    final question = widget.questions[_index];
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: constraints.maxHeight / 2.5,
                child: Image.asset('assets/images/logo.png'),
              ),
              Column(children: [
                Text(
                  question.text,
                  style: TextStyle(
                    fontSize: 20 * textScaleFactor,
                  ),
                ),
                ...question.options
                    .map(
                      (option) => [
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.9,
                          child: ElevatedButton(
                            child: Text(
                              option.text,
                              style: TextStyle(
                                fontSize: 30 * textScaleFactor,
                              ),
                            ),
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.symmetric(vertical: 10),
                              ),
                            ),
                            onPressed: () => _selectOption(option),
                          ),
                        ),
                      ],
                    )
                    .expand((element) => element)
                    .toList(),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
