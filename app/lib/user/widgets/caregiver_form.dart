import 'package:caregiver_hub/main.dart';
import 'package:caregiver_hub/shared/constants/routes.dart';
import 'package:caregiver_hub/shared/exceptions/service_exception.dart';
import 'package:caregiver_hub/shared/models/service.dart';
import 'package:caregiver_hub/shared/models/skill.dart';
import 'package:caregiver_hub/shared/providers/profile_provider.dart';
import 'package:caregiver_hub/shared/validation/functions.dart';
import 'package:caregiver_hub/shared/validation/validators.dart';
import 'package:caregiver_hub/shared/widgets/multi_select_chip_field_custom.dart';
import 'package:caregiver_hub/shared/services/service_service.dart';
import 'package:caregiver_hub/shared/services/skill_service.dart';
import 'package:caregiver_hub/user/models/caregiver_form_data.dart';
import 'package:caregiver_hub/user/services/user_service.dart';
import 'package:caregiver_hub/user/widgets/checkbox_custom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CaregiverForm extends StatefulWidget {
  final CaregiverFormData data;

  const CaregiverForm({Key? key, required this.data}) : super(key: key);

  @override
  State<CaregiverForm> createState() => _CaregiverFormState();
}

class _CaregiverFormState extends State<CaregiverForm> {
  final _userService = getIt<UserService>();
  final _serviceService = getIt<ServiceService>();
  final _skillService = getIt<SkillService>();

  final _formKey = GlobalKey<FormState>();

  bool _disabled = false;

  bool? _showAsCaregiver;
  String? _bio;
  List<Service?>? _services;
  List<Skill?>? _skills;

  void _submit(BuildContext context) async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      setState(() => _disabled = true);
      try {
        await _userService.updateCaregiverData(
          userId: Provider.of<ProfileProvider>(context, listen: false).id,
          showAsCaregiver: _showAsCaregiver!,
          bio: _bio,
          services: _services!
              .where((element) => element != null)
              .map((element) => element!)
              .toList(),
          skills: _skills!
              .where((element) => element != null)
              .map((element) => element!)
              .toList(),
        );
        Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.jobList,
          (route) => false, // Remove todas as telas do stack
        );
      } on ServiceException catch (e) {
        _showSnackBar(context, e.message);
      }
      setState(() => _disabled = false);
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (bContext, constraints) => Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: CheckboxCustom(
                  initialValue: widget.data.showAsCaregiver,
                  readOnly: _disabled,
                  falseLabel: 'Não aparecer como cuidador',
                  trueLabel: 'Aparecer como cuidador',
                  onSaved: (value) => _showAsCaregiver = value ?? false,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Bio',
                  ),
                  readOnly: _disabled,
                  minLines: 5,
                  maxLines: 20,
                  initialValue: widget.data.bio,
                  onSaved: (value) => _bio = value,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: MultiSelectChipFieldCustom<Service, String>(
                  stream: _serviceService.fetchServices(),
                  displayOnly: _disabled,
                  idFn: (serviceType) =>
                      serviceType == null ? '' : serviceType.id,
                  labelFn: (serviceType) =>
                      serviceType == null ? '' : serviceType.description,
                  title: 'Serviços',
                  initialValue: widget.data.services,
                  onSaved: (values) => _services = values,
                  validator: composeValidators([
                    atLeast(
                      1,
                      message: 'É necessário selecionar pelo menos um serviço',
                    )
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: MultiSelectChipFieldCustom<Skill, String>(
                  stream: _skillService.fetchSkills(),
                  displayOnly: _disabled,
                  idFn: (serviceType) =>
                      serviceType == null ? '' : serviceType.id,
                  labelFn: (serviceType) =>
                      serviceType == null ? '' : serviceType.description,
                  title: 'Habilidades',
                  initialValue: widget.data.skills,
                  onSaved: (values) => _skills = values,
                  validator: composeValidators([
                    atLeast(
                      1,
                      message:
                          'É necessário selecionar pelo menos uma habilidade',
                    ),
                  ]),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                width: double.infinity,
                child: ElevatedButton(
                  child: Text(
                    'Salvar',
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
