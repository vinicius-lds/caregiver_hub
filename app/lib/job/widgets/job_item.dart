import 'package:caregiver_hub/job/models/job.dart';
import 'package:caregiver_hub/job/widgets/job_status_type_icon.dart';
import 'package:caregiver_hub/main.dart';
import 'package:caregiver_hub/shared/constants/routes.dart';
import 'package:caregiver_hub/shared/models/job_user_data.dart';
import 'package:caregiver_hub/shared/providers/profile_provider.dart';
import 'package:caregiver_hub/shared/services/user_service.dart';
import 'package:caregiver_hub/shared/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JobItem extends StatelessWidget {
  final UserService _userService = getIt<UserService>();

  final Job job;

  JobItem({
    Key? key,
    required this.job,
  }) : super(key: key);

  void _pushJobScreen(BuildContext context, JobUserData jobUserData) {
    Navigator.of(context).pushNamed(Routes.jobDescription,
        arguments: {'job': job, 'jobUserData': jobUserData});
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    return StreamBuilder<JobUserData>(
        stream: _userService.fetchJobUserData(
          userId:
              profileProvider.isCaregiver ? job.caregiverId : job.employerId,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          }
          final data = snapshot.data ?? JobUserData.empty();
          return Card(
            child: InkWell(
              onTap: () => _pushJobScreen(context, data),
              child: ListTile(
                leading: Hero(
                  tag: job.id,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: data.imageURL == null
                        ? const AssetImage(
                            'assets/images/user_profile_placeholder.png',
                          )
                        : NetworkImage(data.imageURL!) as ImageProvider<Object>,
                  ),
                ),
                title: Text(data.name),
                subtitle: JobStatusTypeIcon(
                  jobStatusType: job.jobStatusType,
                ),
              ),
            ),
          );
        });
  }
}
