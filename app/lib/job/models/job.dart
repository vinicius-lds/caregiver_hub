import 'package:caregiver_hub/job/expections/invalid_job_status_type_exception.dart';
import 'package:caregiver_hub/shared/models/service.dart';

class Job {
  final String id;
  final String caregiverId;
  final String caregiverName;
  final String caregiverImageURL;
  final String caregiverPhone;
  final String employerId;
  final String employerName;
  final String employerImageURL;
  final String employerPhone;
  final DateTime startDate;
  final DateTime endDate;
  final List<Service> services;
  final double price;
  final bool isCanceled;
  final bool isApprovedByEmployer;
  final bool isApprovedByCaregiver;

  const Job({
    required this.id,
    required this.caregiverId,
    required this.caregiverName,
    required this.caregiverImageURL,
    required this.caregiverPhone,
    required this.employerId,
    required this.employerName,
    required this.employerImageURL,
    required this.employerPhone,
    required this.startDate,
    required this.endDate,
    required this.services,
    required this.price,
    required this.isCanceled,
    required this.isApprovedByEmployer,
    required this.isApprovedByCaregiver,
  });

  get jobStatusType {
    if (isCanceled) {
      return JobStatusType.canceled;
    }
    if (!isApprovedByCaregiver || !isApprovedByEmployer) {
      return JobStatusType.inNegotiation;
    }
    final now = DateTime.now();
    if (startDate.isAfter(now)) {
      return JobStatusType.scheduled;
    }
    if ((startDate.isBefore(now) || startDate.isAtSameMomentAs(now)) &&
        (endDate.isAfter(now) || endDate.isAtSameMomentAs(now))) {
      return JobStatusType.inProgress;
    }
    if (endDate.isBefore(now)) {
      return JobStatusType.done;
    }
    throw InvalidJobStatusTypeException();
  }
}

enum JobStatusType {
  inNegotiation,
  canceled,
  scheduled,
  inProgress,
  done,
}
