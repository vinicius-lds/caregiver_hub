import 'package:caregiver_hub/shared/models/skill.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SkillService {
  final _firestore = FirebaseFirestore.instance;

  Stream<List<Skill>> fetchSkills() {
    return _firestore
        .collection('skills')
        .orderBy('description')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (item) => Skill(
                  id: item.id,
                  description: item.data()['description'],
                ),
              )
              .toList(),
        );
  }
}
