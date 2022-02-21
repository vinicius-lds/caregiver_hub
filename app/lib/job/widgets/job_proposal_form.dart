import 'package:caregiver_hub/job/models/job.dart';
import 'package:caregiver_hub/job/services/job_service.dart';
import 'package:caregiver_hub/main.dart';
import 'package:caregiver_hub/shared/constants/routes.dart';
import 'package:caregiver_hub/shared/exceptions/service_exception.dart';
import 'package:caregiver_hub/shared/models/caregiver.dart';
import 'package:caregiver_hub/shared/models/place_coordinates.dart';
import 'package:caregiver_hub/shared/models/service.dart';
import 'package:caregiver_hub/shared/providers/app_state_provider.dart';
import 'package:caregiver_hub/shared/validation/functions.dart';
import 'package:caregiver_hub/shared/validation/validators.dart';
import 'package:caregiver_hub/shared/widgets/date_time_picker.dart';
import 'package:caregiver_hub/shared/widgets/multi_select_chip_field_custom.dart';
import 'package:caregiver_hub/shared/widgets/place_coordinates_field.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class JobProposalForm extends StatefulWidget {
  final Caregiver caregiver;
  final Job? job;

  const JobProposalForm({
    Key? key,
    required this.caregiver,
    required this.job,
  }) : super(key: key);

  @override
  _JobProposalFormState createState() => _JobProposalFormState();
}

class _JobProposalFormState extends State<JobProposalForm> {
  final _jobService = getIt<JobService>();

  final _formKey = GlobalKey<FormState>();

  final _priceController = MoneyMaskedTextController(leftSymbol: 'R\$ ');

  bool _disabled = false;

  PlaceCoordinates? _placeCoordinates;
  DateTime? _startDate;
  DateTime? _endDate;
  List<Service?>? _services;

  void _editProposal(BuildContext context, {required Job job}) async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();

    setState(() => _disabled = true);
    final appStateProvider =
        Provider.of<AppStateProvider>(context, listen: false);
    try {
      await _jobService.editProposal(
        jobId: widget.job!.id,
        placeCoordinates: _placeCoordinates!,
        startDate: _startDate!,
        endDate: _endDate!,
        services: (_services ?? [])
            .where((item) => item != null)
            .map((item) => item!)
            .toList(),
        price: _priceController.numberValue,
        isCaregiver: appStateProvider.isCaregiver,
      );
    } on ServiceException catch (e) {
      _showSnackBar(context, e.message);
    }
    setState(() => _disabled = false);

    Navigator.of(context).pushNamedAndRemoveUntil(
      Routes.jobList,
      (route) => false, // Remove todas as telas do stack
    );
  }

  void _makeProposal(BuildContext context, {required String caregiverId}) {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();

    setState(() => _disabled = true);
    try {
      final appStateProvider =
          Provider.of<AppStateProvider>(context, listen: false);
      _jobService.makeProposal(
        caregiverId: widget.caregiver.id,
        employerId: appStateProvider.id,
        placeCoordinates: _placeCoordinates!,
        startDate: _startDate!,
        endDate: _endDate!,
        services: (_services ?? [])
            .where((item) => item != null)
            .map((item) => item!)
            .toList(),
        price: _priceController.numberValue,
      );
    } on ServiceException catch (e) {
      _showSnackBar(context, e.message);
    }
    setState(() => _disabled = false);

    Navigator.of(context).pushNamedAndRemoveUntil(
      Routes.jobList,
      (route) => false, // Remove todas as telas do stack
    );
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
    final formatter =
        NumberFormat.simpleCurrency(decimalDigits: 2, locale: 'pt_BR');
    final startPriceString = widget.caregiver.startPrice != null
        ? formatter.format(widget.caregiver.startPrice)
        : null;
    final endPriceString = widget.caregiver.endPrice != null
        ? formatter.format(widget.caregiver.endPrice)
        : null;
    _priceController.text = widget.job?.price.toStringAsFixed(2) ?? '';
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          alignment: Alignment.center,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: PlaceCoordinatesField(
                  initialValue: widget.job?.placeCoordinates,
                  disabled: _disabled,
                  decoration: const InputDecoration(
                    label: Text('Localização'),
                  ),
                  onSaved: (value) => _placeCoordinates = value,
                  validator: requiredValue(message: 'O campo é obrigatório'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: DateTimePicker(
                  label: 'Início da atividade',
                  disabled: _disabled,
                  initialValue: widget.job?.startDate,
                  validator: composeValidators([
                    requiredValue(message: 'O campo é obrigatório'),
                    after(
                      () => _endDate,
                      message:
                          'O início não pode ser igual ou superior ao fim da atividade',
                    ),
                    before(
                      () => DateTime.now(),
                      message:
                          'O início não pode ser igual ou anterior ao horário atual',
                    ),
                  ]),
                  onSaved: (value) => _startDate = value,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: DateTimePicker(
                  label: 'Fim da atividade',
                  disabled: _disabled,
                  initialValue: widget.job?.endDate,
                  validator: composeValidators([
                    requiredValue(message: 'O campo é obrigatório'),
                    before(
                      () => _startDate,
                      message:
                          'O fim não pode ser igual ou inferior ao início da atividade',
                    ),
                    before(
                      () => DateTime.now(),
                      message:
                          'O fim não pode ser igual ou anterior ao horário atual',
                    ),
                  ]),
                  onSaved: (value) => _endDate = value,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: MultiSelectChipFieldCustom<Service, String>(
                  items: widget.caregiver.services,
                  displayOnly: _disabled,
                  initialValue: widget.job?.services,
                  idFn: (serviceType) =>
                      serviceType == null ? '' : serviceType.id,
                  labelFn: (serviceType) =>
                      serviceType == null ? '' : serviceType.description,
                  title: 'Serviços',
                  validator: composeValidators([
                    atLeast(
                      () => 1,
                      message: 'É necessário selecionar pelo menos um serviço',
                    )
                  ]),
                  onTap: (values) => _services = values,
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Valor',
                ),
                readOnly: _disabled,
                controller: _priceController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => widget.job == null
                    ? _makeProposal(
                        context,
                        caregiverId: widget.caregiver.id,
                      )
                    : _editProposal(context, job: widget.job!),
                validator: composeValidators([
                  requiredValue(message: 'O campo é obrigatório'),
                  greaterThan(
                    () => widget.caregiver.endPrice ?? 0,
                    message: 'O valor não pode ser superior a $endPriceString',
                    doubleParser: (value) => _priceController.numberValue,
                  ),
                  lessThan(
                    () => widget.caregiver.startPrice ?? 0,
                    message:
                        'O valor não pode ser inferior a $startPriceString',
                    doubleParser: (value) => _priceController.numberValue,
                  ),
                ]),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                width: double.infinity,
                child: ElevatedButton(
                  child: Text(
                    widget.job == null ? 'Enviar proposta' : 'Editar proposta',
                    style: TextStyle(
                      fontSize: 15 * textScaleFactor,
                    ),
                  ),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                  onPressed: _disabled
                      ? null
                      : () => widget.job == null
                          ? _makeProposal(
                              context,
                              caregiverId: widget.caregiver.id,
                            )
                          : _editProposal(context, job: widget.job!),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
