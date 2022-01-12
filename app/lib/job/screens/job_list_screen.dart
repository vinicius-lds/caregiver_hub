import 'package:caregiver_hub/job/models/job.dart';
import 'package:caregiver_hub/job/providers/job_provider.dart';
import 'package:caregiver_hub/job/widgets/job_item.dart';
import 'package:caregiver_hub/shared/providers/profile_provider.dart';
import 'package:caregiver_hub/shared/widgets/app_bar_popup_menu_button.dart';
import 'package:caregiver_hub/shared/widgets/button_footer.dart';
import 'package:caregiver_hub/shared/widgets/empty_state.dart';
import 'package:caregiver_hub/shared/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class JobListScreen extends StatefulWidget {
  const JobListScreen({Key? key}) : super(key: key);

  @override
  State<JobListScreen> createState() => _JobListScreenState();
}

class _JobListScreenState extends State<JobListScreen> {
  int _offset = 0;
  final int _size = 15;

  @override
  Widget build(BuildContext context) {
    final jobProvider = Provider.of<JobProvider>(context);
    final profileProvider = Provider.of<ProfileProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('CaregiverHub'),
        actions: const [
          AppBarPopupMenuButton(),
        ],
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<List<dynamic>>(
          stream: CombineLatestStream.list([
            jobProvider.listStream(
              caregiverId:
                  profileProvider.isCaregiver ? profileProvider.id : null,
              userId: !profileProvider.isCaregiver ? profileProvider.id : null,
              offset: _offset,
              size: _size,
            ),
            jobProvider.count(
              caregiverId:
                  profileProvider.isCaregiver ? profileProvider.id : null,
              userId: !profileProvider.isCaregiver ? profileProvider.id : null,
            ),
          ]),
          builder: (bContext, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Loading();
            }
            if (!snapshot.hasData) {
              return const EmptyState(text: 'Nenhum trabalho encontrado');
            }
            final data = snapshot.data as List<dynamic>;
            final jobs = data[0] as List<Job>;
            final count = data[1] as int;
            return Column(
              children: [
                ...jobs.map((job) => JobItem(job: job)).toList(),
                ButtonFooter(
                  primaryText: 'Próximo',
                  secondaryText: 'Anterior',
                  onPrimary: (_offset + 1) * _size > count
                      ? null
                      : () => setState(() => _offset++),
                  onSecondary:
                      _offset == 0 ? null : () => setState(() => _offset--),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
