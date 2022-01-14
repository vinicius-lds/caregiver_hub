import 'package:caregiver_hub/shared/models/skill.dart';
import 'package:flutter/foundation.dart';

class SkillProvider with ChangeNotifier {
  final List<Skill> _items = _loadMockData();

  Stream<List<Skill>> listStream() {
    return Stream.value(_items);
  }
}

List<Skill> _loadMockData() {
  return [
    const Skill(id: '1', description: 'Habilidade 1'),
    const Skill(id: '2', description: 'Habilidade 2'),
    const Skill(id: '3', description: 'Habilidade 3'),
    const Skill(id: '4', description: 'Habilidade 4'),
    const Skill(id: '5', description: 'Habilidade 5'),
    const Skill(id: '6', description: 'Habilidade 6'),
    const Skill(id: '7', description: 'Habilidade 7'),
    const Skill(id: '8', description: 'Habilidade 8'),
  ];
}
