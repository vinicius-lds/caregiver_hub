import 'package:caregiver_hub/shared/constants/routes.dart';
import 'package:caregiver_hub/shared/models/service.dart';
import 'package:caregiver_hub/shared/models/skill.dart';
import 'package:caregiver_hub/shared/providers/caregiver_provider.dart';
import 'package:caregiver_hub/shared/providers/service_provider.dart';
import 'package:caregiver_hub/shared/providers/skill_provider.dart';
import 'package:caregiver_hub/shared/widgets/date_time_picker.dart';
import 'package:caregiver_hub/shared/widgets/multi_select_chip_field_custom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CaregiverFilterScreen extends StatefulWidget {
  const CaregiverFilterScreen({Key? key}) : super(key: key);

  @override
  State<CaregiverFilterScreen> createState() => _CaregiverFilterScreenState();
}

class _CaregiverFilterScreenState extends State<CaregiverFilterScreen> {
  final _formKey = GlobalKey<FormState>();

  DateTime? _startDate;
  DateTime? _endDate;
  List<Service?>? _services;
  List<Skill?>? _skills;

  void _applyFilter(BuildContext context) {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      final caregiverProvider =
          Provider.of<CaregiverProvider>(context, listen: false);
      caregiverProvider.applyFilter(
        startDate: _startDate,
        endDate: _endDate,
        services: _services,
        skills: _skills,
      );
      Navigator.of(context).pushNamed(Routes.caregiverList);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final serviceProvider = Provider.of<ServiceProvider>(context);
    final skillTypeProvider = Provider.of<SkillProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('CaregiverHub'),
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
                    onSaved: (value) => _startDate = value,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: DateTimePicker(
                    label: 'Fim da atividade',
                    onSaved: (value) => _endDate = value,
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
                    onTap: (values) => _services = values,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: MultiSelectChipFieldCustom<Skill, String>(
                    stream: skillTypeProvider.listStream(),
                    idFn: (skillType) => skillType == null ? '' : skillType.id,
                    labelFn: (skillType) =>
                        skillType == null ? '' : skillType.description,
                    title: 'Habilidades',
                    onTap: (values) => _skills = values,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text(
                      'Aplicar filtro',
                      style: TextStyle(
                        fontSize: 15 * textScaleFactor,
                      ),
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                    onPressed: () => _applyFilter(context),
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
