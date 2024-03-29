import 'package:caregiver_hub/main.dart';
import 'package:caregiver_hub/shared/providers/app_state_provider.dart';
import 'package:caregiver_hub/shared/widgets/app_bar_popup_menu_button.dart';
import 'package:caregiver_hub/shared/widgets/loading.dart';
import 'package:caregiver_hub/social/models/chat_message.dart';
import 'package:caregiver_hub/social/services/chat_service.dart';
import 'package:caregiver_hub/social/widgets/chat_app_bar_title.dart';
import 'package:caregiver_hub/social/widgets/message_buble.dart';
import 'package:caregiver_hub/social/widgets/message_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  final _chatService = getIt<ChatService>();

  final ScrollController _controller = ScrollController();

  ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appStateProvider = Provider.of<AppStateProvider>(context);
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final otherUserImageURL = args['otherUserImageURL'] as String?;
    final otherUserName = args['otherUserName'] as String;
    final otherUserId = args['otherUserId'] as String;

    return Scaffold(
      appBar: AppBar(
        title: ChatAppBarTitle(
          imageURL: otherUserImageURL,
          name: otherUserName,
        ),
        actions: [
          AppBarPopupMenuButton(),
        ],
      ),
      body: StreamBuilder<List<ChatMessage>>(
        stream: _chatService.fetchChatMessages(
          employerId:
              appStateProvider.isCaregiver ? otherUserId : appStateProvider.id,
          caregiverId:
              appStateProvider.isCaregiver ? appStateProvider.id : otherUserId,
        ),
        builder: (bContext, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox(
              width: double.infinity,
              child: Loading(),
            );
          }
          final List<ChatMessage> data = snapshot.data ?? [];
          return LayoutBuilder(
            builder: (bContext, constraints) => Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _controller,
                    itemCount: data.length,
                    reverse: true,
                    itemBuilder: (bContext, index) {
                      final reversedIndex = data.length - 1 - index;
                      return MessageBubble(
                        content: data[reversedIndex].content,
                        isReceived: data[reversedIndex].createdBy !=
                            appStateProvider.id,
                      );
                    },
                  ),
                ),
                MessageInput(
                  otherUserId: otherUserId,
                  onSend: () =>
                      _controller.jumpTo(_controller.position.minScrollExtent),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
