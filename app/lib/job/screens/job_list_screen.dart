import 'package:caregiver_hub/job/models/job.dart';
import 'package:caregiver_hub/job/services/job_service.dart';
import 'package:caregiver_hub/job/widgets/job_item.dart';
import 'package:caregiver_hub/main.dart';
import 'package:caregiver_hub/shared/constants/pagination.dart';
import 'package:caregiver_hub/shared/providers/app_state_provider.dart';
import 'package:caregiver_hub/shared/widgets/app_bar_popup_menu_button.dart';
import 'package:caregiver_hub/shared/widgets/empty_state.dart';
import 'package:caregiver_hub/shared/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JobListScreen extends StatefulWidget {
  const JobListScreen({Key? key}) : super(key: key);

  @override
  State<JobListScreen> createState() => _JobListScreenState();
}

class _JobListScreenState extends State<JobListScreen> {
  final _jobService = getIt<JobService>();

  int _size = pageSize;

  @override
  Widget build(BuildContext context) {
    final appStateProvider = Provider.of<AppStateProvider>(context);
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trabalhos'),
        actions: [
          AppBarPopupMenuButton(),
        ],
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<List<Job>>(
          stream: _jobService.fetchJobs(
            caregiverId:
                appStateProvider.isCaregiver ? appStateProvider.id : null,
            employerId:
                !appStateProvider.isCaregiver ? appStateProvider.id : null,
            size: _size,
          ),
          builder: (bContext, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loading();
            }
            if (!snapshot.hasData) {
              return const EmptyState(text: 'Nenhum trabalho encontrado');
            }
            final jobs = snapshot.data as List<Job>;
            if (jobs.isEmpty) {
              return const EmptyState(text: 'Nenhum trabalho encontrado');
            }
            return Column(
              children: [
                ...jobs.map((job) => JobItem(job: job)).toList(),
                if (jobs.length == _size)
                  ElevatedButton(
                    child: Text(
                      'Carregar mais',
                      style: TextStyle(
                        fontSize: 15 * textScaleFactor,
                      ),
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                      ),
                    ),
                    onPressed: () => setState(() => _size += pageSize),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
