class Service {
  static const Service SERVICE_01 = Service._('SERVICE_01', 'Serviço 1');
  static const Service SERVICE_02 = Service._('SERVICE_02', 'Serviço 2');
  static const Service SERVICE_03 = Service._('SERVICE_03', 'Serviço 3');
  static const Service SERVICE_04 = Service._('SERVICE_04', 'Serviço 4');
  static const Service SERVICE_05 = Service._('SERVICE_05', 'Serviço 5');

  static List<Service> get values {
    return [SERVICE_01, SERVICE_02, SERVICE_03, SERVICE_04, SERVICE_05];
  }

  static Map<String, bool> toFlagMap(List<Service> trueServices) {
    final Map<String, bool> result = {};
    for (final service in values) {
      result[service.key] = false;
    }
    for (final service in trueServices) {
      result[service.key] = true;
    }
    return result;
  }

  static List<Service> fromServicesFlagMap(
    Map<String, dynamic> servicesFlagMap,
  ) {
    final List<Service> result = [];
    for (final entry in servicesFlagMap.entries) {
      if (entry.value != true) {
        continue;
      }
      final serviceFilter = values.where((element) => element.key == entry.key);
      if (serviceFilter.isEmpty || serviceFilter.length > 1) {
        continue;
      }
      final service = serviceFilter.single;
      result.add(service);
    }
    return result;
  }

  final String key;
  final String description;

  const Service._(this.key, this.description);

  factory Service.fromKey(String key) {
    return values.where((element) => element.key == key).single;
  }
}
