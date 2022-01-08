import 'package:caregiver_hub/employer/models/skill_type.dart';
import 'package:flutter/foundation.dart';

class SkillTypeProvider with ChangeNotifier {
  final List<SkillType> _items = _loadMockData();

  Stream<List<SkillType>> listStream() {
    return Stream.value(_items);
  }
}

List<SkillType> _loadMockData() {
  return [
    const SkillType(id: '1', description: 'Habilidade 1'),
    const SkillType(id: '2', description: 'Habilidade 2'),
    const SkillType(id: '3', description: 'Habilidade 3'),
    const SkillType(id: '4', description: 'Habilidade 4'),
    const SkillType(id: '5', description: 'Habilidade 5'),
    const SkillType(id: '6', description: 'Habilidade 6'),
    const SkillType(id: '7', description: 'Habilidade 7'),
    const SkillType(id: '8', description: 'Habilidade 8'),
  ];
}
