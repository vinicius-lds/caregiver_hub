import 'package:caregiver_hub/caregiver/models/caregiver_recomendation_form_data.dart';
import 'package:caregiver_hub/caregiver/widgets/star_rating.dart';
import 'package:caregiver_hub/shared/validation/functions.dart';
import 'package:caregiver_hub/shared/validation/validators.dart';
import 'package:flutter/material.dart';

class CaregiverRecomendationForm extends StatefulWidget {
  final CaregiverRecomendationFormData data;

  const CaregiverRecomendationForm({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<CaregiverRecomendationForm> createState() =>
      _CaregiverRecomendationFormState();
}

class _CaregiverRecomendationFormState
    extends State<CaregiverRecomendationForm> {
  final _formKey = GlobalKey<FormState>();

  String? _recomendation;
  int? _rating;

  void _submit(BuildContext context) {
    print('submit');
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      print('rating $_rating');
    }
  }

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Form(
      key: _formKey,
      child: LayoutBuilder(
        builder: (bContext, constraints) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: constraints.maxWidth * 0.5,
                height: constraints.maxWidth * 0.5,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(constraints.maxWidth * 0.5),
                  ),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(widget.data.caregiverImageURL),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  widget.data.caregiverName,
                  style: TextStyle(
                    fontSize: 25 * textScaleFactor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: StarRating(
                  initialValue: widget.data.rating?.toDouble(),
                  onSaved: (value) => _rating = value?.toInt(),
                  validator: composeValidators([
                    requiredValue(message: 'É obrigatório avaliar o cuidador'),
                  ]),
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Recomendação',
                ),
                minLines: 5,
                maxLines: 20,
                initialValue: widget.data.recomendation,
                onFieldSubmitted: (_) => _submit(context),
                onSaved: (value) => _recomendation = value,
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                width: double.infinity,
                child: ElevatedButton(
                  child: Text(
                    'Salvar recomendação',
                    style: TextStyle(
                      fontSize: 15 * textScaleFactor,
                    ),
                  ),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                  onPressed: () => _submit(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
