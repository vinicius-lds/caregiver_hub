import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String content;
  final bool isReceived;

  const MessageBubble({
    Key? key,
    required this.content,
    required this.isReceived,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(4),
      alignment: isReceived ? Alignment.centerLeft : Alignment.centerRight,
      // decoration: BoxDecoration(
      //     color: Colors.red,
      //     border: Border.all(),
      //     ),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isReceived ? Colors.blue : Colors.white,
          border: Border.all(),
          borderRadius: BorderRadius.only(
            bottomLeft: isReceived ? Radius.zero : const Radius.circular(15),
            bottomRight: isReceived ? const Radius.circular(15) : Radius.zero,
            topLeft: const Radius.circular(15),
            topRight: const Radius.circular(15),
          ),
        ),
        child: Text(
          content,
          style: TextStyle(
            color: isReceived ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
