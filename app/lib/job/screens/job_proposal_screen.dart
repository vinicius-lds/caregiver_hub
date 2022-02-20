import 'package:caregiver_hub/job/models/job.dart';
import 'package:caregiver_hub/job/widgets/job_proposal_form.dart';
import 'package:caregiver_hub/main.dart';
import 'package:caregiver_hub/shared/models/caregiver.dart';
import 'package:caregiver_hub/shared/providers/caregiver_provider.dart';
import 'package:caregiver_hub/shared/services/caregiver_service.dart';
import 'package:caregiver_hub/shared/widgets/app_bar_popup_menu_button.dart';
import 'package:caregiver_hub/shared/widgets/empty_state.dart';
import 'package:caregiver_hub/shared/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JobProposalScreen extends StatefulWidget {
  const JobProposalScreen({Key? key}) : super(key: key);

  @override
  State<JobProposalScreen> createState() => _JobProposalScreenState();
}

class _JobProposalScreenState extends State<JobProposalScreen> {
  final CaregiverService _caregiverService = getIt<CaregiverService>();

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final caregiverId = args['caregiverId'] as String?;
    final job = args['job'] as Job?;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Proposta de trabalho'),
        actions: [
          AppBarPopupMenuButton(),
        ],
      ),
      body: StreamBuilder<Caregiver>(
        stream: _caregiverService.fetchCaregiver(
          id: caregiverId ?? job!.caregiverId,
        ),
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
