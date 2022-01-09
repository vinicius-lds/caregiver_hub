import 'package:flutter/material.dart';

class ContactItem extends StatelessWidget {
  final ImageProvider<Object> icon;
  final double size;
  final void Function() onTap;

  const ContactItem({
    Key? key,
    required this.icon,
    required this.size,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: const BorderRadius.all(Radius.circular(80)),
      child: Container(
        width: size,
        height: size,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(80)),
        ),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: icon,
            ),
          ),
        ),
      ),
    );
  }
}
