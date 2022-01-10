import 'package:caregiver_hub/shared/widgets/contact_item.dart';
import 'package:flutter/material.dart';

class ContactsBar extends StatelessWidget {
  final double size;
  final String otherUserId;
  final String otherUserPhone;

  const ContactsBar({
    Key? key,
    required this.size,
    required this.otherUserId,
    required this.otherUserPhone,
  }) : super(key: key);

  void _pushChat(BuildContext context) {
    print('pushChat');
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
