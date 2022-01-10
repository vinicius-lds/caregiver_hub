import 'package:caregiver_hub/job/models/job.dart';
import 'package:caregiver_hub/shared/models/service.dart';
import 'package:flutter/foundation.dart';

class JobProvider with ChangeNotifier {
  Stream<List<Job>> listStream({
    final String? caregiverId,
    final String? userId,
    final int offset = 0,
    final int size = 15,
  }) {
    return Stream.value([
      ..._loadMockData(0),
      ..._loadMockData(1),
      ..._loadMockData(2),
      ..._loadMockData(3),
    ]);
  }

  Stream<int> count({
    final String? caregiverId,
    final String? userId,
  }) {
    return Stream.value(6);
  }
}

List<Job> _loadMockData(int i) {
  return [
    Job(
      id: (1 + (i * 6)).toString(),
      caregiverName: 'Alice Monteiro Cordeiro',
      caregiverImageURL: 'https://picsum.photos/1920/1080?random=1',
      employerName: 'Iara Álves Quintana',
      employerImageURL: 'https://picsum.photos/1920/1080?random=2',
      startDate: DateTime(2023),
      endDate: DateTime(2024),
      services: const [
        Service(id: '1', description: 'Serviço 1'),
        Service(id: '2', description: 'Serviço 2'),
      ],
      price: 1000,
      isCanceled: false,
      isApprovedByCaregiver: false,
      isApprovedByEmployer: true,
    ),
    Job(
      id: (2 + (i * 6)).toString(),
      caregiverName: 'Clarice Amaral Henriques',
      caregiverImageURL: 'https://picsum.photos/1920/1080?random=3',
      employerName: 'Cláudia Ávila da Cunha',
      employerImageURL: 'https://picsum.photos/1920/1080?random=4',
      startDate: DateTime(2023),
      endDate: DateTime(2024),
      services: const [
        Service(id: '3', description: 'Serviço 3'),
      ],
      price: 1500,
      isCanceled: true,
      isApprovedByCaregiver: false,
      isApprovedByEmployer: false,
    ),
    Job(
      id: (3 + (i * 6)).toString(),
      caregiverName: 'Betina Vila Moreira',
      caregiverImageURL: 'https://picsum.photos/1920/1080?random=5',
      employerName: 'Manoela Pereira Cardoso',
      employerImageURL: 'https://picsum.photos/1920/1080?random=6',
      startDate: DateTime(2023),
      endDate: DateTime(2024),
      services: const [
        Service(id: '3', description: 'Serviço 3'),
        Service(id: '6', description: 'Serviço 6'),
        Service(id: '7', description: 'Serviço 7'),
      ],
      price: 2500,
      isCanceled: false,
      isApprovedByCaregiver: true,
      isApprovedByEmployer: false,
    ),
    Job(
      id: (4 + (i * 6)).toString(),
      caregiverName: 'Beatriz Medeiras Higashi',
      caregiverImageURL: 'https://picsum.photos/1920/1080?random=7',
      employerName: 'Vanuza Maldonado Meireles',
      employerImageURL: 'https://picsum.photos/1920/1080?random=8',
      startDate: DateTime(2023),
      endDate: DateTime(2024),
      services: const [
        Service(id: '8', description: 'Serviço 8'),
      ],
      price: 500,
      isCanceled: false,
      isApprovedByCaregiver: true,
      isApprovedByEmployer: true,
    ),
    Job(
      id: (5 + (i * 6)).toString(),
      caregiverName: 'Miriam Lacerda Fraga',
      caregiverImageURL: 'https://picsum.photos/1920/1080?random=9',
      employerName: 'Paula Ramos Farias',
      employerImageURL: 'https://picsum.photos/1920/1080?random=10',
      startDate: DateTime(2022),
      endDate: DateTime(2023),
      services: const [
        Service(id: '8', description: 'Serviço 8'),
        Service(id: '9', description: 'Serviço 9'),
        Service(id: '12', description: 'Serviço 12'),
      ],
      price: 900,
      isCanceled: false,
      isApprovedByCaregiver: true,
      isApprovedByEmployer: true,
    ),
    Job(
      id: (6 + (i * 6)).toString(),
      caregiverName: 'Isadora Belluci da Cunha',
      caregiverImageURL: 'https://picsum.photos/1920/1080?random=11',
      employerName: 'Flávia Garcia Lemos',
      employerImageURL: 'https://picsum.photos/1920/1080?random=12',
      startDate: DateTime(2020),
      endDate: DateTime(2021),
      services: const [
        Service(id: '3', description: 'Serviço 3'),
      ],
      price: 1200,
      isCanceled: false,
      isApprovedByCaregiver: true,
      isApprovedByEmployer: true,
    ),
  ];
}
