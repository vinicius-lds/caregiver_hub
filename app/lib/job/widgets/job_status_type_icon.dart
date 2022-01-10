import 'package:caregiver_hub/job/expections/invalid_job_status_type_exception.dart';
import 'package:caregiver_hub/job/models/job.dart';
import 'package:flutter/material.dart';

class JobStatusTypeIcon extends StatelessWidget {
  final JobStatusType jobStatusType;
  const JobStatusTypeIcon({
    Key? key,
    required final this.jobStatusType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (jobStatusType) {
      case JobStatusType.inNegotiation:
        return Row(
          children: const [
            Icon(Icons.pending, color: Colors.grey),
            Padding(
              padding: EdgeInsets.only(left: 4),
              child: Text('Em negociação'),
            ),
          ],
        );
      case JobStatusType.canceled:
        return Row(
          children: const [
            Icon(Icons.cancel, color: Colors.red),
            Padding(
              padding: EdgeInsets.only(left: 4),
              child: Text('Cancelado'),
            ),
          ],
        );
      case JobStatusType.scheduled:
        return Row(
          children: const [
            Icon(Icons.schedule),
            Padding(
              padding: EdgeInsets.only(left: 4),
              child: Text('Agendado'),
            ),
          ],
        );
      case JobStatusType.inProgress:
        return Row(
          children: const [
            Icon(Icons.settings, color: Colors.blue),
            Padding(
              padding: EdgeInsets.only(left: 4),
              child: Text('Em progresso'),
            ),
          ],
        );
      case JobStatusType.done:
        return Row(
          children: const [
            Icon(Icons.done, color: Colors.green),
            Padding(
              padding: EdgeInsets.only(left: 4),
              child: Text('Concluído'),
            ),
          ],
        );
      default:
        throw InvalidJobStatusTypeException();
    }
  }
}
