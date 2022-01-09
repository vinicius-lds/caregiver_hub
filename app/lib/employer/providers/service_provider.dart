import 'package:caregiver_hub/employer/models/service.dart';
import 'package:flutter/foundation.dart';

class ServiceProvider with ChangeNotifier {
  final List<Service> _items = _loadMockData();

  Stream<List<Service>> listStream() {
    return Stream.value(_items);
  }
}

List<Service> _loadMockData() {
  return [
    const Service(id: '1', description: 'Tipo de serviço 1'),
    const Service(id: '2', description: 'Tipo de serviço 2'),
    const Service(id: '3', description: 'Tipo de serviço 3'),
    const Service(id: '4', description: 'Tipo de serviço 4'),
    const Service(id: '5', description: 'Tipo de serviço 5'),
    const Service(id: '6', description: 'Tipo de serviço 6'),
    const Service(id: '7', description: 'Tipo de serviço 7'),
    const Service(id: '8', description: 'Tipo de serviço 8'),
  ];
}
