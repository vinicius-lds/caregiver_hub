import 'package:caregiver_hub/main.dart';
import 'package:caregiver_hub/shared/providers/app_state_provider.dart';
import 'package:caregiver_hub/social/services/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageInput extends StatefulWidget {
  final String otherUserId;
  final VoidCallback onSend;

  const MessageInput({
    Key? key,
    required this.otherUserId,
    required this.onSend,
  }) : super(key: key);

  @override
  _MessageInputState createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final _chatService = getIt<ChatService>();

  final _formKey = GlobalKey<FormState>();

  final _focusNode = FocusNode();

  String? _message;

  void _send() async {
    _formKey.currentState!.save();
    if (_message == null || _message!.trim() == '') {
      return;
    }
    final appStateProvider =
        Provider.of<AppStateProvider>(context, listen: false);
    _formKey.currentState!.reset();
    _focusNode.requestFocus();
    await _chatService.pushMessage(
      _message!,
      caregiverId: appStateProvider.isCaregiver
          ? appStateProvider.id
          : widget.otherUserId,
      employerId: appStateProvider.isCaregiver
          ? widget.otherUserId
          : appStateProvider.id,
    );
    widget.onSend();
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
