import 'package:caregiver_hub/job/models/job.dart';
import 'package:caregiver_hub/job/widgets/job_status_type_icon.dart';
import 'package:caregiver_hub/shared/constants/routes.dart';
import 'package:caregiver_hub/shared/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JobItem extends StatelessWidget {
  final Job job;

  const JobItem({
    Key? key,
    required this.job,
  }) : super(key: key);

  void _pushJobScreen(BuildContext context) {
    Navigator.of(context)
        .pushNamed(Routes.jobDescription, arguments: {'job': job});
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    return Card(
      child: InkWell(
        onTap: () => _pushJobScreen(context),
        child: ListTile(
          leading: Hero(
            tag: job.id,
            child: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                profileProvider.isCaregiver
                    ? job.employerImageURL
                    : job.caregiverImageURL,
              ),
            ),
          ),
          title: Text(
            profileProvider.isCaregiver ? job.employerName : job.caregiverName,
          ),
          subtitle: JobStatusTypeIcon(
            jobStatusType: job.jobStatusType,
          ),
        ),
      ),
    );
  }
}
