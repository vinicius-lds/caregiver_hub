import 'package:caregiver_hub/shared/constants/routes.dart';
import 'package:caregiver_hub/shared/models/service.dart';
import 'package:caregiver_hub/shared/validation/functions.dart';
import 'package:caregiver_hub/shared/validation/validators.dart';
import 'package:caregiver_hub/shared/widgets/app_bar_popup_menu_button.dart';
import 'package:caregiver_hub/shared/widgets/date_time_picker.dart';
import 'package:caregiver_hub/shared/widgets/multi_select_chip_field_custom.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class JobFormScreen extends StatefulWidget {
  const JobFormScreen({Key? key}) : super(key: key);

  @override
  State<JobFormScreen> createState() => _JobFormScreenState();
}

class _JobFormScreenState extends State<JobFormScreen> {
  final _formKey = GlobalKey<FormState>();

  DateTime? _startDate;
  DateTime? _endDate;
  List<Service?>? _services;
  String? _price;

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

    Navigator.of(context).pushNamed(Routes.jobList);
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final caregiverId = args['caregiverId'] as String;
    final availableServices = args['availableServices'] as List<Service>;
    final startPrice = args['startPrice'] as double?;
    final endPrice = args['endPrice'] as double?;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final formatter =
        NumberFormat.simpleCurrency(decimalDigits: 2, locale: 'pt_BR');
    final startPriceString =
        startPrice != null ? formatter.format(startPrice) : null;
    final endPriceString = endPrice != null ? formatter.format(endPrice) : null;
    return Scaffold(
      appBar: AppBar(
        title: const Text('CaregiverHub'),
        actions: const [
          AppBarPopupMenuButton(),
        ],
      ),
      body: Form(
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
                    items: availableServices,
                    idFn: (serviceType) =>
                        serviceType == null ? '' : serviceType.id,
                    labelFn: (serviceType) =>
                        serviceType == null ? '' : serviceType.description,
                    title: 'Serviços',
                    validator: composeValidators([
                      atLeast(
                        1,
                        message:
                            'É necessário selecionar pelo menos um serviço',
                      )
                    ]),
                    onTap: (values) => _services = values,
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Valor',
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  inputFormatters: [
                    CurrencyTextInputFormatter(
                      decimalDigits: 2,
                      locale: 'pt_BR',
                      symbol: 'R\$',
                    )
                  ],
                  keyboardType: TextInputType.number,
                  onSaved: (value) => _price = value,
                  textInputAction: TextInputAction.next,
                  validator: composeValidators([
                    requiredValue(message: 'O campo é obrigatório'),
                    _greaterThan(
                      endPrice,
                      message:
                          'O valor não pode ser superior a $endPriceString',
                    ),
                    _lowerThan(
                      startPrice,
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
                      'Enviar proposta',
                      style: TextStyle(
                        fontSize: 15 * textScaleFactor,
                      ),
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                    onPressed: () =>
                        _makeProposal(context, caregiverId: caregiverId),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
