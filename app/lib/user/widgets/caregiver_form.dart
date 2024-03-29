import 'package:caregiver_hub/main.dart';
import 'package:caregiver_hub/shared/constants/routes.dart';
import 'package:caregiver_hub/shared/exceptions/service_exception.dart';
import 'package:caregiver_hub/shared/models/location.dart';
import 'package:caregiver_hub/shared/models/service.dart';
import 'package:caregiver_hub/shared/models/skill.dart';
import 'package:caregiver_hub/shared/providers/app_state_provider.dart';
import 'package:caregiver_hub/shared/utils/gui.dart';
import 'package:caregiver_hub/shared/validation/functions.dart';
import 'package:caregiver_hub/shared/validation/validators.dart';
import 'package:caregiver_hub/shared/widgets/location_field.dart';
import 'package:caregiver_hub/shared/widgets/multi_select_chip_field_custom.dart';
import 'package:caregiver_hub/shared/models/caregiver_form_data.dart';
import 'package:caregiver_hub/shared/services/user_service.dart';
import 'package:caregiver_hub/user/widgets/checkbox_custom.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
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

  final _formKey = GlobalKey<FormState>();

  final _startPriceController = MoneyMaskedTextController(leftSymbol: 'R\$ ');
  final _endPriceController = MoneyMaskedTextController(leftSymbol: 'R\$ ');

  bool _disabled = false;

  bool? _showAsCaregiver;
  Location? _location;
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
          userId: Provider.of<AppStateProvider>(context, listen: false).id,
          showAsCaregiver: _showAsCaregiver!,
          location: _location!,
          bio: _bio,
          services: _services!
              .where((element) => element != null)
              .map((element) => element!)
              .toList(),
          skills: _skills!
              .where((element) => element != null)
              .map((element) => element!)
              .toList(),
          startPrice: _startPriceController.numberValue,
          endPrice: _endPriceController.numberValue,
        );
        Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.jobList,
          (route) => false, // Remove todas as telas do stack
        );
      } on ServiceException catch (e) {
        showSnackBar(context, e.message);
      }
      setState(() => _disabled = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    _startPriceController.text = widget.data.startPrice.toStringAsFixed(2);
    _endPriceController.text = widget.data.endPrice.toStringAsFixed(2);
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
                child: LocationField(
                  decoration: const InputDecoration(
                    label: Text('Área de atuação'),
                  ),
                  initialValue: widget.data.location,
                  radiusSelection: true,
                  radiusMinValue: 100, // 100 meters
                  radiusMaxValue: 25000, // 25 kilometers
                  onSaved: (value) => _location = value,
                  validator: composeValidators([
                    requiredValue(message: 'O campo é obrigatório'),
                  ]),
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
                  items: Service.values,
                  displayOnly: _disabled,
                  idFn: (serviceType) =>
                      serviceType == null ? '' : serviceType.key,
                  labelFn: (serviceType) =>
                      serviceType == null ? '' : serviceType.description,
                  title: 'Serviços',
                  initialValue: widget.data.services,
                  onSaved: (values) => _services = values,
                  validator: composeValidators([
                    atLeast(
                      () => 1,
                      message: 'É necessário selecionar pelo menos um serviço',
                    )
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: MultiSelectChipFieldCustom<Skill, String>(
                  items: Skill.values,
                  displayOnly: _disabled,
                  idFn: (serviceType) =>
                      serviceType == null ? '' : serviceType.key,
                  labelFn: (serviceType) =>
                      serviceType == null ? '' : serviceType.description,
                  title: 'Habilidades',
                  initialValue: widget.data.skills,
                  onSaved: (values) => _skills = values,
                  validator: composeValidators([
                    atLeast(
                      () => 1,
                      message:
                          'É necessário selecionar pelo menos uma habilidade',
                    ),
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Preço inicial',
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  readOnly: _disabled,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  controller: _startPriceController,
                  validator: composeValidators([
                    greaterThan(
                      () => _startPriceController.numberValue > 0 &&
                              _endPriceController.numberValue > 0
                          ? _endPriceController.numberValue
                          : double.infinity,
                      message:
                          'O valor inicial deve ser inferior ao valor final',
                      doubleParser: (value) =>
                          _startPriceController.numberValue,
                    ),
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Preço final',
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  readOnly: _disabled,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  controller: _endPriceController,
                  onFieldSubmitted: (_) => _submit(context),
                  validator: composeValidators([
                    lessThan(
                      () => _startPriceController.numberValue > 0 &&
                              _endPriceController.numberValue > 0
                          ? _startPriceController.numberValue
                          : -1,
                      message:
                          'O valor final deve ser superior ao valor inicial',
                      doubleParser: (value) => _endPriceController.numberValue,
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
