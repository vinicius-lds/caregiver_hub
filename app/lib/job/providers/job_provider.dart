import 'package:caregiver_hub/job/models/job.dart';
import 'package:caregiver_hub/shared/models/place_coordinates.dart';
import 'package:caregiver_hub/shared/models/service.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
      caregiverId: '1',
      caregiverName: 'Alice Monteiro Cordeiro',
      caregiverImageURL: 'https://picsum.photos/1920/1080?random=1',
      caregiverPhone: '+5547955729869',
      employerId: '1',
      employerName: 'Iara Álves Quintana',
      employerImageURL: 'https://picsum.photos/1920/1080?random=2',
      employerPhone: '+5547955729869',
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
      placeCoordinates: const PlaceCoordinates(
        id: '1',
        description: 'FURB',
        coordinates: LatLng(-26.904855945456372, -49.07916968582165),
      ),
    ),
    Job(
      id: (2 + (i * 6)).toString(),
      caregiverId: '2',
      caregiverName: 'Clarice Amaral Henriques',
      caregiverImageURL: 'https://picsum.photos/1920/1080?random=3',
      caregiverPhone: '+5547955729869',
      employerId: '1',
      employerName: 'Cláudia Ávila da Cunha',
      employerImageURL: 'https://picsum.photos/1920/1080?random=4',
      employerPhone: '+5547955729869',
      startDate: DateTime(2023),
      endDate: DateTime(2024),
      services: const [
        Service(id: '3', description: 'Serviço 3'),
      ],
      price: 1500,
      isCanceled: true,
      isApprovedByCaregiver: false,
      isApprovedByEmployer: false,
      placeCoordinates: const PlaceCoordinates(
        id: '1',
        description: 'FURB',
        coordinates: LatLng(-26.904855945456372, -49.07916968582165),
      ),
    ),
    Job(
      id: (3 + (i * 6)).toString(),
      caregiverId: '3',
      caregiverName: 'Betina Vila Moreira',
      caregiverImageURL: 'https://picsum.photos/1920/1080?random=5',
      caregiverPhone: '+5547955729869',
      employerId: '1',
      employerName: 'Manoela Pereira Cardoso',
      employerImageURL: 'https://picsum.photos/1920/1080?random=6',
      employerPhone: '+5547955729869',
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
      placeCoordinates: const PlaceCoordinates(
        id: '1',
        description: 'FURB',
        coordinates: LatLng(-26.904855945456372, -49.07916968582165),
      ),
    ),
    Job(
      id: (4 + (i * 6)).toString(),
      caregiverId: '4',
      caregiverName: 'Beatriz Medeiras Higashi',
      caregiverImageURL: 'https://picsum.photos/1920/1080?random=7',
      caregiverPhone: '+5547955729869',
      employerId: '1',
      employerName: 'Vanuza Maldonado Meireles',
      employerImageURL: 'https://picsum.photos/1920/1080?random=8',
      employerPhone: '+5547955729869',
      startDate: DateTime(2023),
      endDate: DateTime(2024),
      services: const [
        Service(id: '8', description: 'Serviço 8'),
      ],
      price: 500,
      isCanceled: false,
      isApprovedByCaregiver: true,
      isApprovedByEmployer: true,
      placeCoordinates: const PlaceCoordinates(
        id: '1',
        description: 'FURB',
        coordinates: LatLng(-26.904855945456372, -49.07916968582165),
      ),
    ),
    Job(
      id: (5 + (i * 6)).toString(),
      caregiverId: '5',
      caregiverName: 'Miriam Lacerda Fraga',
      caregiverImageURL: 'https://picsum.photos/1920/1080?random=9',
      caregiverPhone: '+5547955729869',
      employerId: '1',
      employerName: 'Paula Ramos Farias',
      employerImageURL: 'https://picsum.photos/1920/1080?random=10',
      employerPhone: '+5547955729869',
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
      placeCoordinates: const PlaceCoordinates(
        id: '1',
        description: 'FURB',
        coordinates: LatLng(-26.904855945456372, -49.07916968582165),
      ),
    ),
    Job(
      id: (6 + (i * 6)).toString(),
      caregiverId: '6',
      caregiverName: 'Isadora Belluci da Cunha',
      caregiverImageURL: 'https://picsum.photos/1920/1080?random=11',
      caregiverPhone: '+5547955729869',
      employerId: '1',
      employerName: 'Flávia Garcia Lemos',
      employerImageURL: 'https://picsum.photos/1920/1080?random=12',
      employerPhone: '+5547955729869',
      startDate: DateTime(2020),
      endDate: DateTime(2021),
      services: const [
        Service(id: '3', description: 'Serviço 3'),
      ],
      price: 1200,
      isCanceled: false,
      isApprovedByCaregiver: true,
      isApprovedByEmployer: true,
      placeCoordinates: const PlaceCoordinates(
        id: '1',
        description: 'FURB',
        coordinates: LatLng(-26.904855945456372, -49.07916968582165),
      ),
    ),
  ];
}
