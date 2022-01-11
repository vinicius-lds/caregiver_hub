import 'package:caregiver_hub/shared/constants/routes.dart';
import 'package:caregiver_hub/shared/widgets/contact_item.dart';
import 'package:flutter/material.dart';

class ContactsBar extends StatelessWidget {
  final double size;
  final String otherUserId;
  final String otherUserImageURL;
  final String otherUserName;
  final String otherUserPhone;

  const ContactsBar({
    Key? key,
    required this.size,
    required this.otherUserId,
    required this.otherUserImageURL,
    required this.otherUserName,
    required this.otherUserPhone,
  }) : super(key: key);

  void _pushChat(BuildContext context) {
    print('pushChat');
    Navigator.of(context).pushNamed(Routes.chat, arguments: {
      'userId': otherUserId,
      'name': otherUserName,
      'imageURL': otherUserImageURL,
    });
  }

  void _pushWhatsApp(BuildContext context) {
    print('pushWhatsApp');
  }

  void _pushPhone(BuildContext context) {
    print('pushPhone');
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ContactItem(
          icon: const AssetImage('assets/images/chat.png'),
          size: size,
          onTap: () => _pushChat(context),
        ),
        ContactItem(
          icon: const AssetImage('assets/images/whatsapp.png'),
          size: size,
          onTap: () => _pushWhatsApp(context),
        ),
        ContactItem(
          icon: const AssetImage('assets/images/phone.png'),
          size: size,
          onTap: () => _pushPhone(context),
        ),
      ],
    );
  }
}
