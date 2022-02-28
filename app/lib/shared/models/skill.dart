class Skill {
  static const Skill SKILL_01 = Skill._('SKILL_01', 'Habilidade 1');
  static const Skill SKILL_02 = Skill._('SKILL_02', 'Habilidade 2');
  static const Skill SKILL_03 = Skill._('SKILL_03', 'Habilidade 3');
  static const Skill SKILL_04 = Skill._('SKILL_04', 'Habilidade 4');
  static const Skill SKILL_05 = Skill._('SKILL_05', 'Habilidade 5');

  static List<Skill> get values {
    return [SKILL_01, SKILL_02, SKILL_03, SKILL_04, SKILL_05];
  }

  static Map<String, bool> toFlagMap(List<Skill> trueSkills) {
    final Map<String, bool> result = {};
    for (final skill in values) {
      result[skill.key] = false;
    }
    for (final skill in trueSkills) {
      result[skill.key] = true;
    }
    return result;
  }

  static List<Skill> fromSkillsFlagMap(Map<String, dynamic> skillsFlagMap) {
    final List<Skill> result = [];
    for (final entry in skillsFlagMap.entries) {
      if (entry.value != true) {
        continue;
      }
      final skillFilter = values.where((element) => element.key == entry.key);
      if (skillFilter.isEmpty || skillFilter.length > 1) {
        continue;
      }
      final skill = skillFilter.single;
      result.add(skill);
    }
    return result;
  }

  final String key;
  final String description;

  const Skill._(this.key, this.description);

  factory Skill.fromKey(String key) {
    return values.where((element) => element.key == key).single;
  }
}
