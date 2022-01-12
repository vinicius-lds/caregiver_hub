import 'package:caregiver_hub/shared/providers/profile_provider.dart';
import 'package:caregiver_hub/shared/widgets/app_bar_popup_menu_button.dart';
import 'package:caregiver_hub/shared/widgets/loading.dart';
import 'package:caregiver_hub/social/models/chat_message.dart';
import 'package:caregiver_hub/social/providers/chat_message_provider.dart';
import 'package:caregiver_hub/social/widgets/chat_app_bar_title.dart';
import 'package:caregiver_hub/social/widgets/message_buble.dart';
import 'package:caregiver_hub/social/widgets/message_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final chatMessageProvider = Provider.of<ChatMessageProvider>(context);
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final imageURL = args['imageURL'] as String;
    final name = args['name'] as String;
    final userId = args['userId'] as String;

    return Scaffold(
      appBar: AppBar(
        title: ChatAppBarTitle(imageURL: imageURL, name: name),
        actions: const [
          AppBarPopupMenuButton(),
        ],
      ),
      body: StreamBuilder<List<ChatMessage>>(
        stream: chatMessageProvider.listStream(
          userId: profileProvider.id,
          otherUserId: userId,
        ),
        builder: (bContext, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const SizedBox(
              width: double.infinity,
              child: Loading(),
            );
          }
          if (!snapshot.hasData) {
            return Container();
          }
          final data = snapshot.data as List<ChatMessage>;
          if (data.isEmpty) {
            return Container();
          }
          return LayoutBuilder(
            builder: (bContext, constraints) => Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (bContext, index) {
                      return MessageBubble(
                        content: data[index].content,
                        isReceived:
                            data[index].sendingUserId == profileProvider.id,
                      );
                    },
                  ),
                ),
                const MessageInput(),
              ],
            ),
          );
        },
      ),
    );
  }
}
