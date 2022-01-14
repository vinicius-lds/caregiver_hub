import 'package:caregiver_hub/shared/models/service.dart';
import 'package:caregiver_hub/shared/models/skill.dart';
import 'package:caregiver_hub/user/models/caregiver_form_data.dart';
import 'package:caregiver_hub/user/models/user_form_data.dart';
import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  Stream<CaregiverFormData> caregiverFormDataStream({required String id}) {
    return Stream.value(_loadMockCaregiverFormData(id));
  }

  Stream<UserFormData> userFormDataStream({required String id}) {
    return Stream.value(_loadMockUserFormData(id));
  }
}

UserFormData _loadMockUserFormData(String id) {
  return const UserFormData(
    id: '1',
    imageURL: 'https://picsum.photos/1920/1080?random=52',
    name: 'Bruna Alves Carvalho',
    cpf: '13338687079',
    phone: '+5547955729869',
    email: 'teste@gmail.com',
  );
}

CaregiverFormData _loadMockCaregiverFormData(String id) {
  return CaregiverFormData(
    id: id,
    isActive: true,
    bio:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    services: const [
      Service(id: '1', description: 'Serviço 1'),
      Service(id: '2', description: 'Serviço 2'),
    ],
    skills: const [
      Skill(id: '1', description: 'Habilidade 1'),
      Skill(id: '2', description: 'Habilidade 2'),
    ],
  );
}
