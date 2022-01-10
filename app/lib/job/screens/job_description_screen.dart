import 'package:caregiver_hub/job/models/job.dart';
import 'package:caregiver_hub/job/widgets/job_detail_action_button.dart';
import 'package:caregiver_hub/shared/constants/routes.dart';
import 'package:caregiver_hub/shared/models/service.dart';
import 'package:caregiver_hub/shared/providers/profile_provider.dart';
import 'package:caregiver_hub/shared/widgets/app_bar_popup_menu_button.dart';
import 'package:caregiver_hub/shared/widgets/button_footer.dart';
import 'package:caregiver_hub/shared/widgets/contacts_bar.dart';
import 'package:caregiver_hub/shared/widgets/multi_select_chip_field_custom.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class JobDescriptionScreen extends StatelessWidget {
  const JobDescriptionScreen({Key? key}) : super(key: key);

  void _accept(BuildContext context, Job job) {
    print('accept');
    Navigator.of(context).pop();
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

  void _cancel(BuildContext context, Job job) {
    print('cancel');
    Navigator.of(context).pop();
  }

  void _edit(BuildContext context, Job job) {
    print('edit');
    Navigator.of(context).pushNamed(Routes.jobForm, arguments: {'job': job});
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final job = args['job'] as Job;
    final profileProvider = Provider.of<ProfileProvider>(context);
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return LayoutBuilder(
      builder: (bContext, constraints) => Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: constraints.maxHeight * 0.33,
              pinned: true,
              actions: const [
                AppBarPopupMenuButton(),
              ],
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  profileProvider.isCaregiver
                      ? job.employerName
                      : job.caregiverName,
                ),
                background: Hero(
                  tag: job.id,
                  child: Image.network(
                    profileProvider.isCaregiver
                        ? job.employerImageURL
                        : job.caregiverImageURL,
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
                        otherUserId: profileProvider.isCaregiver
                            ? job.employerId
                            : job.caregiverId,
                        otherUserPhone: profileProvider.isCaregiver
                            ? job.employerPhone
                            : job.caregiverPhone,
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: const Text('Localização'),
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
                            text: 'Cancelar',
                            color: Colors.red,
                            icon: const Icon(Icons.cancel),
                            onPressed: () => _cancel(context, job),
                          ),
                        ),
                      if (job.jobStatusType == JobStatusType.inNegotiation &&
                          ((profileProvider.isCaregiver &&
                                  !job.isApprovedByCaregiver) ||
                              (!profileProvider.isCaregiver &&
                                  !job.isApprovedByEmployer)))
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: JobDetailActionButton(
                            text: 'Aceitar termos',
                            color: Theme.of(context).primaryColor,
                            icon: const Icon(Icons.done),
                            onPressed: () => _accept(context, job),
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
