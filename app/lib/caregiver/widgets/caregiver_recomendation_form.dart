import 'package:caregiver_hub/caregiver/models/caregiver_recomendation_form_data.dart';
import 'package:caregiver_hub/caregiver/services/caregiver_recomendation_service.dart';
import 'package:caregiver_hub/caregiver/widgets/star_rating.dart';
import 'package:caregiver_hub/main.dart';
import 'package:caregiver_hub/shared/exceptions/service_exception.dart';
import 'package:caregiver_hub/shared/models/caregiver_recomendation_user_data.dart';
import 'package:caregiver_hub/shared/providers/app_state_provider.dart';
import 'package:caregiver_hub/shared/utils/gui.dart';
import 'package:caregiver_hub/shared/validation/functions.dart';
import 'package:caregiver_hub/shared/validation/validators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CaregiverRecomendationForm extends StatefulWidget {
  final CaregiverRecomendationFormData caregiverRecomendationFormData;
  final CaregiverRecomendationUserData caregiverRecomendationUserData;

  const CaregiverRecomendationForm({
    Key? key,
    required this.caregiverRecomendationFormData,
    required this.caregiverRecomendationUserData,
  }) : super(key: key);

  @override
  State<CaregiverRecomendationForm> createState() =>
      _CaregiverRecomendationFormState();
}

class _CaregiverRecomendationFormState
    extends State<CaregiverRecomendationForm> {
  final _caregiverRecomendationService = getIt<CaregiverRecomendationService>();

  final _formKey = GlobalKey<FormState>();

  bool _disabled = false;

  String? _recomendation;
  int? _rating;

  void _submit(BuildContext context) async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      setState(() => _disabled = true);
      try {
        final appStateProvider =
            Provider.of<AppStateProvider>(context, listen: false);
        if (widget.caregiverRecomendationFormData.id == null) {
          await _caregiverRecomendationService.createCaregiverRecomendation(
            employerId: appStateProvider.id,
            caregiverId: widget.caregiverRecomendationFormData.caregiverId,
            recomendation: _recomendation,
            rating: _rating!,
          );
        } else {
          await _caregiverRecomendationService.updateCaregiverRecomendation(
            id: widget.caregiverRecomendationFormData.id!,
            recomendation: _recomendation,
            rating: _rating!,
          );
        }
        Navigator.of(context).pop();
      } on ServiceException catch (e) {
        showSnackBar(context, e.message);
      }
      setState(() => _disabled = false);
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
                    image:
                        widget.caregiverRecomendationUserData.imageURL == null
                            ? const AssetImage(
                                'assets/images/user_profile_placeholder.png',
                              )
                            : NetworkImage(
                                widget.caregiverRecomendationUserData.imageURL!,
                              ) as ImageProvider<Object>,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  widget.caregiverRecomendationUserData.name,
                  style: TextStyle(
                    fontSize: 25 * textScaleFactor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: StarRating(
                  initialValue:
                      widget.caregiverRecomendationFormData.rating?.toDouble(),
                  displayOnly: _disabled,
                  onSaved: (value) => _rating = value?.toInt(),
                  validator: composeValidators([
                    requiredValue(message: 'É obrigatório avaliar o cuidador'),
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Recomendação',
                  ),
                  readOnly: _disabled,
                  minLines: 5,
                  maxLines: 20,
                  initialValue:
                      widget.caregiverRecomendationFormData.recomendation,
                  onFieldSubmitted: (_) => _submit(context),
                  onSaved: (value) => _recomendation = value,
                ),
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
                  onPressed: _disabled ? null : () => _submit(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
