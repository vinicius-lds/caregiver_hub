import 'package:caregiver_hub/employer/models/service_type.dart';
import 'package:flutter/foundation.dart';

class ServiceTypeProvider with ChangeNotifier {
  final List<ServiceType> _items = _loadMockData();

  Stream<List<ServiceType>> listStream() {
    return Stream.value(_items);
  }
}

List<ServiceType> _loadMockData() {
  return [
    const ServiceType(id: '1', description: 'Tipo de serviço 1'),
    const ServiceType(id: '2', description: 'Tipo de serviço 2'),
    const ServiceType(id: '3', description: 'Tipo de serviço 3'),
    const ServiceType(id: '4', description: 'Tipo de serviço 4'),
    const ServiceType(id: '5', description: 'Tipo de serviço 5'),
    const ServiceType(id: '6', description: 'Tipo de serviço 6'),
    const ServiceType(id: '7', description: 'Tipo de serviço 7'),
    const ServiceType(id: '8', description: 'Tipo de serviço 8'),
  ];
}
