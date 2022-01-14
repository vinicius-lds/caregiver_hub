import 'package:caregiver_hub/job/models/job.dart';
import 'package:caregiver_hub/shared/constants/routes.dart';
import 'package:caregiver_hub/shared/models/caregiver.dart';
import 'package:caregiver_hub/shared/models/service.dart';
import 'package:caregiver_hub/shared/validation/functions.dart';
import 'package:caregiver_hub/shared/validation/validators.dart';
import 'package:caregiver_hub/shared/widgets/date_time_picker.dart';
import 'package:caregiver_hub/shared/widgets/multi_select_chip_field_custom.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  final _formKey = GlobalKey<FormState>();

  DateTime? _startDate;
  DateTime? _endDate;
  List<Service?>? _services;
  String? _price;

  void _editProposal(BuildContext context, {required Job job}) {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();

    final price = _formattedPriceToDouble(_price!);
    print('''
    editProposal
    $_startDate
    $_endDate
    $_services
    $price
    ''');

    Navigator.of(context).pushNamedAndRemoveUntil(
      Routes.jobList,
      (route) => false, // Remove todas as telas do stack
    );
  }

  double _formattedPriceToDouble(String formattedPrice) {
    return double.parse(
      formattedPrice
          .replaceAll('R\$', '')
          .replaceAll(' ', '')
          .replaceAll('.', '')
          .replaceAll(',', '.'),
    );
  }

  String? Function(dynamic) _greaterThan(
    double? other, {
    required String message,
  }) {
    return (value) {
      if (value != null &&
          other != null &&
          value is String &&
          _formattedPriceToDouble(value) > other) {
        return message;
      }
      return null;
    };
  }

  String? Function(dynamic) _lowerThan(
    double? other, {
    required String message,
  }) {
    return (value) {
      if (value != null &&
          other != null &&
          value is String &&
          _formattedPriceToDouble(value) < other) {
        return message;
      }
      return null;
    };
  }

  void _makeProposal(BuildContext context, {required String caregiverId}) {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();

    final price = _formattedPriceToDouble(_price!);
    print('''
    makeProposal
    $_startDate
    $_endDate
    $_services
    $price
    ''');

    Navigator.of(context).pushNamedAndRemoveUntil(
      Routes.jobList,
      (route) => false, // Remove todas as telas do stack
    );
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
    final currencyTextInputFormatter = CurrencyTextInputFormatter(
      decimalDigits: 2,
      locale: 'pt_BR',
      symbol: 'R\$',
    );
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          alignment: Alignment.center,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Text('Localização'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: DateTimePicker(
                  label: 'Início da atividade',
                  initialValue: widget.job?.startDate,
                  validator: composeValidators([
                    requiredValue(message: 'O campo é obrigatório'),
                    after(
                      _endDate,
                      message:
                          'O início não pode ser igual ou superior ao fim da atividade',
                    ),
                  ]),
                  onChange: (value) => setState(() => _startDate = value),
                  onSaved: (value) => setState(() => _startDate = value),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: DateTimePicker(
                  label: 'Fim da atividade',
                  initialValue: widget.job?.endDate,
                  validator: composeValidators([
                    requiredValue(message: 'O campo é obrigatório'),
                    before(
                      _startDate,
                      message:
                          'O fim não pode ser igual ou inferior ao início da atividade',
                    ),
                  ]),
                  onChange: (value) => setState(() => _endDate = value),
                  onSaved: (value) => setState(() => _endDate = value),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: MultiSelectChipFieldCustom<Service, String>(
                  items: widget.caregiver.services,
                  initialValue: widget.job?.services,
                  idFn: (serviceType) =>
                      serviceType == null ? '' : serviceType.id,
                  labelFn: (serviceType) =>
                      serviceType == null ? '' : serviceType.description,
                  title: 'Serviços',
                  validator: composeValidators([
                    atLeast(
                      1,
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
                initialValue: widget.job != null
                    ? currencyTextInputFormatter
                        .format(widget.job!.price.toStringAsFixed(2))
                    : null,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                inputFormatters: [currencyTextInputFormatter],
                keyboardType: TextInputType.number,
                onSaved: (value) => _price = value,
                textInputAction: TextInputAction.next,
                validator: composeValidators([
                  requiredValue(message: 'O campo é obrigatório'),
                  _greaterThan(
                    widget.caregiver.endPrice,
                    message: 'O valor não pode ser superior a $endPriceString',
                  ),
                  _lowerThan(
                    widget.caregiver.startPrice,
                    message:
                        'O valor não pode ser inferior a $startPriceString',
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
                  onPressed: () => widget.job == null
                      ? _makeProposal(context, caregiverId: widget.caregiver.id)
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
