import 'package:caregiver_hub/shared/constants/routes.dart';
import 'package:caregiver_hub/shared/widgets/contact_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactsBar extends StatelessWidget {
  final double size;
  final String otherUserId;
  final String? otherUserImageURL;
  final String otherUserName;
  final String otherUserPhone;
  final String otherUserEmail;

  const ContactsBar({
    Key? key,
    required this.size,
    required this.otherUserId,
    required this.otherUserImageURL,
    required this.otherUserName,
    required this.otherUserPhone,
    required this.otherUserEmail,
  }) : super(key: key);

  void _pushChat(BuildContext context) {
    Navigator.of(context).pushNamed(Routes.chat, arguments: {
      'otherUserId': otherUserId,
      'otherUserName': otherUserName,
      'otherUserImageURL': otherUserImageURL,
    });
  }

  void _pushWhatsApp(BuildContext context) async {
    await FlutterLaunch.launchWhatsapp(
      phone: '55992681107',
      message: 'Hello',
    );
  }

  void _pushEmail(BuildContext context) {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: otherUserEmail,
      query: _encodeQueryParameters(
          <String, String>{'subject': 'Negociação no CaregiverHub!'}),
    );
    launch(emailLaunchUri.toString());
  }

  String? _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
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
          icon: const AssetImage('assets/images/email.png'),
          size: size,
          onTap: () => _pushEmail(context),
        ),
      ],
    );
  }
}
