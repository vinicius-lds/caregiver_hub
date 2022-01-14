import 'package:caregiver_hub/caregiver/providers/service_provider.dart';
import 'package:caregiver_hub/caregiver/providers/skill_provider.dart';
import 'package:caregiver_hub/shared/constants/routes.dart';
import 'package:caregiver_hub/shared/models/service.dart';
import 'package:caregiver_hub/shared/models/skill.dart';
import 'package:caregiver_hub/shared/validation/functions.dart';
import 'package:caregiver_hub/shared/validation/validators.dart';
import 'package:caregiver_hub/shared/widgets/multi_select_chip_field_custom.dart';
import 'package:caregiver_hub/user/models/caregiver_form_data.dart';
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
  final _formKey = GlobalKey<FormState>();

  bool? _isActive;
  String? _bio;
  List<Service?>? _services;
  List<Skill?>? _skills;

  void _submit(BuildContext context) {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    print('submit');
    Navigator.of(context).pushNamedAndRemoveUntil(
      Routes.jobList,
      (route) => false, // Remove todas as telas do stack
    );
  }

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final serviceProvider = Provider.of<ServiceProvider>(context);
    final skillProvider = Provider.of<SkillProvider>(context);
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (bContext, constraints) => Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: CheckboxCustom(
                  initialValue: widget.data.isActive,
                  falseLabel: 'Não aparecer como cuidador',
                  trueLabel: 'Aparecer como cuidador',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Bio',
                  ),
                  minLines: 5,
                  maxLines: 20,
                  initialValue: widget.data.bio,
                  onSaved: (value) => _bio = value,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: MultiSelectChipFieldCustom<Service, String>(
                  stream: serviceProvider.listStream(),
                  idFn: (serviceType) =>
                      serviceType == null ? '' : serviceType.id,
                  labelFn: (serviceType) =>
                      serviceType == null ? '' : serviceType.description,
                  title: 'Serviços',
                  initialValue: widget.data.services,
                  onTap: (values) => _services = values,
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
                  stream: skillProvider.listStream(),
                  idFn: (serviceType) =>
                      serviceType == null ? '' : serviceType.id,
                  labelFn: (serviceType) =>
                      serviceType == null ? '' : serviceType.description,
                  title: 'Habilidades',
                  initialValue: widget.data.skills,
                  onTap: (values) => _skills = values,
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
