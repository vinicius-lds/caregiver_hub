import 'package:flutter/material.dart';

class MessageInput extends StatefulWidget {
  const MessageInput({Key? key}) : super(key: key);

  @override
  _MessageInputState createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final _formKey = GlobalKey<FormState>();

  final _focusNode = FocusNode();

  String? _message;

  void _send() {
    _formKey.currentState!.save();
    print('send $_message');
    _formKey.currentState!.reset();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (bContext, constraints) => Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Mensagem',
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onSaved: (value) => _message = value,
                    onFieldSubmitted: (_) => _send(),
                    focusNode: _focusNode,
                  ),
                ),
              ),
              InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(80)),
                onTap: _send,
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(Icons.send),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
