import 'package:caregiver_hub/job/models/job.dart';
import 'package:caregiver_hub/job/widgets/job_proposal_form.dart';
import 'package:caregiver_hub/shared/constants/routes.dart';
import 'package:caregiver_hub/shared/models/caregiver.dart';
import 'package:caregiver_hub/shared/models/service.dart';
import 'package:caregiver_hub/shared/providers/caregiver_provider.dart';
import 'package:caregiver_hub/shared/validation/functions.dart';
import 'package:caregiver_hub/shared/validation/validators.dart';
import 'package:caregiver_hub/shared/widgets/app_bar_popup_menu_button.dart';
import 'package:caregiver_hub/shared/widgets/date_time_picker.dart';
import 'package:caregiver_hub/shared/widgets/empty_state.dart';
import 'package:caregiver_hub/shared/widgets/loading.dart';
import 'package:caregiver_hub/shared/widgets/multi_select_chip_field_custom.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class JobProposalScreen extends StatefulWidget {
  const JobProposalScreen({Key? key}) : super(key: key);

  @override
  State<JobProposalScreen> createState() => _JobProposalScreenState();
}

class _JobProposalScreenState extends State<JobProposalScreen> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final caregiverId = args['caregiverId'] as String?;
    final job = args['job'] as Job?;
    final caregiverProvider = Provider.of<CaregiverProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Proposta de trabalho'),
        actions: [
          AppBarPopupMenuButton(),
        ],
      ),
      body: StreamBuilder<Caregiver>(
        stream: caregiverProvider.byId(caregiverId ?? job!.caregiverId),
        builder: (bContext, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Loading();
          }
          if (!snapshot.hasData) {
            return const EmptyState(
              text: 'Não foi possível buscar os dados do cuidador',
            );
          }
          final data = snapshot.data as Caregiver;
          return JobProposalForm(
            caregiver: data,
            job: job,
          );
        },
      ),
    );
  }
}
