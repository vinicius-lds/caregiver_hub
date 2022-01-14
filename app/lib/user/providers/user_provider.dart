import 'package:caregiver_hub/user/models/user_form_data.dart';
import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
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
