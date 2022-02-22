import 'package:caregiver_hub/job/models/job.dart';
import 'package:caregiver_hub/job/services/job_service.dart';
import 'package:caregiver_hub/job/widgets/job_detail_action_button.dart';
import 'package:caregiver_hub/main.dart';
import 'package:caregiver_hub/shared/constants/routes.dart';
import 'package:caregiver_hub/shared/exceptions/service_exception.dart';
import 'package:caregiver_hub/shared/models/job_user_data.dart';
import 'package:caregiver_hub/shared/models/service.dart';
import 'package:caregiver_hub/shared/providers/app_state_provider.dart';
import 'package:caregiver_hub/shared/utils/gui.dart';
import 'package:caregiver_hub/shared/widgets/app_bar_popup_menu_button.dart';
import 'package:caregiver_hub/shared/widgets/contacts_bar.dart';
import 'package:caregiver_hub/shared/widgets/multi_select_chip_field_custom.dart';
import 'package:caregiver_hub/shared/widgets/place_coordinates_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class JobDescriptionScreen extends StatefulWidget {
  const JobDescriptionScreen({Key? key}) : super(key: key);

  @override
  State<JobDescriptionScreen> createState() => _JobDescriptionScreenState();
}

class _JobDescriptionScreenState extends State<JobDescriptionScreen> {
  final _jobService = getIt<JobService>();

  bool _disabled = false;

  void _accept(BuildContext context, Job job) async {
    setState(() => _disabled = true);
    try {
      final appStateProvider =
          Provider.of<AppStateProvider>(context, listen: false);
      final now = DateTime.now();
      if (job.startDate.isBefore(now) || job.endDate.isBefore(now)) {
        showSnackBar(
          context,
          'Não é possível aprovar um trabalho com data anterior a atual.',
        );
      } else {
        await _jobService.accept(
          jobId: job.id,
          isCaregiver: appStateProvider.isCaregiver,
        );
        Navigator.of(context).pop();
      }
    } on ServiceException catch (e) {
      showSnackBar(context, e.message);
    }
    setState(() => _disabled = false);
  }

  String _buildJobPeriodString({
    required DateTime startDate,
    required DateTime endDate,
  }) {
    final formatter = DateFormat('dd/MM/yyyy hh:mm');
    final startDateString = formatter.format(startDate);
    final endDateString = formatter.format(endDate);
    return '$startDateString até $endDateString';
  }

  void _cancel(BuildContext context, Job job) async {
    setState(() => _disabled = true);
    try {
      await _jobService.cancel(jobId: job.id);
      Navigator.of(context).pop();
    } on ServiceException catch (e) {
      showSnackBar(context, e.message);
    }
    setState(() => _disabled = false);
  }

  void _edit(BuildContext context, Job job) {
    Navigator.of(context).pushNamed(Routes.jobForm, arguments: {'job': job});
  }

  void _recomenCaregiver(BuildContext context, Job job) {
    Navigator.of(context).pushNamed(Routes.caregiverRecomendation, arguments: {
      'caregiverId': job.caregiverId,
    });
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final job = args['job'] as Job;
    final jobUserData = args['jobUserData'] as JobUserData;
    final appStateProvider = Provider.of<AppStateProvider>(context);
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return LayoutBuilder(
      builder: (bContext, constraints) => Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: constraints.maxHeight * 0.33,
              pinned: true,
              actions: [
                AppBarPopupMenuButton(),
              ],
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  jobUserData.name,
                ),
                background: Hero(
                  tag: job.id,
                  child: jobUserData.imageURL == null
                      ? Image.asset(
                          'assets/images/user_profile_placeholder.png',
                        )
                      : Image.network(
                          jobUserData.imageURL!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      ContactsBar(
                        size: constraints.maxHeight * 0.1,
                        otherUserId: jobUserData.id,
                        otherUserImageURL: jobUserData.imageURL,
                        otherUserName: jobUserData.name,
                        otherUserPhone: jobUserData.phone,
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: PlaceCoordinatesField(
                          readOnly: true,
                          initialValue: job.placeCoordinates,
                          decoration: const InputDecoration(
                            label: Text('Localização'),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          _buildJobPeriodString(
                            startDate: job.startDate,
                            endDate: job.endDate,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: MultiSelectChipFieldCustom<Service, String>(
                          items: job.services,
                          displayOnly: true,
                          idFn: (serviceType) =>
                              serviceType == null ? '' : serviceType.id,
                          labelFn: (serviceType) => serviceType == null
                              ? ''
                              : serviceType.description,
                          title: 'Serviços',
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          NumberFormat.simpleCurrency(
                            decimalDigits: 2,
                            locale: 'pt_BR',
                          ).format(job.price),
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 30 * textScaleFactor,
                          ),
                        ),
                      ),
                      if (job.jobStatusType == JobStatusType.inNegotiation)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: JobDetailActionButton(
                            disabled: _disabled,
                            text: 'Editar termos',
                            color: Colors.grey,
                            icon: const Icon(Icons.edit),
                            onPressed: () => _edit(context, job),
                          ),
                        ),
                      if (job.jobStatusType == JobStatusType.inNegotiation)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: JobDetailActionButton(
                            disabled: _disabled,
                            text: 'Cancelar',
                            color: Colors.red,
                            icon: const Icon(Icons.cancel),
                            onPressed: () => _cancel(context, job),
                          ),
                        ),
                      if (job.jobStatusType == JobStatusType.inNegotiation &&
                          ((appStateProvider.isCaregiver &&
                                  !job.isApprovedByCaregiver) ||
                              (!appStateProvider.isCaregiver &&
                                  !job.isApprovedByEmployer)))
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: JobDetailActionButton(
                            disabled: _disabled,
                            text: 'Aceitar termos',
                            color: Theme.of(context).primaryColor,
                            icon: const Icon(Icons.done),
                            onPressed: () => _accept(context, job),
                          ),
                        ),
                      if (job.jobStatusType == JobStatusType.done &&
                          !appStateProvider.isCaregiver)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: JobDetailActionButton(
                            disabled: _disabled,
                            text: 'Recomendar cuidador',
                            color: Theme.of(context).primaryColor,
                            icon: const Icon(Icons.star_border),
                            onPressed: () => _recomenCaregiver(context, job),
                          ),
                        ),
                    ],
                  ),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
