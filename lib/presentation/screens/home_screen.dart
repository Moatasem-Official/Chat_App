import 'package:chat_app/data/models/message_model.dart';
import 'package:chat_app/presentation/widgets/Home_Screen/custom_app_bar.dart';
import 'package:chat_app/presentation/widgets/Home_Screen/custom_message_composer.dart';
import 'package:chat_app/presentation/widgets/Home_Screen/custom_message_templete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChatHomeScreen extends StatefulWidget {
  const ChatHomeScreen({super.key});

  @override
  State<ChatHomeScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ChatHomeScreen> {
  final TextEditingController _textController = TextEditingController();

  final List<ChatMessage> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: CustomAppBar(),
      ),
      body: Column(
        children: [
          _messages.isEmpty
              ? Expanded(
                  child: Center(
                    child: SvgPicture.asset("assets/images/Chat-cuate.svg"),
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    reverse: false,
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      return CustomMessageTemplete(message: _messages[index]);
                    },
                  ),
                ),
          CustomMessageComposer(
            textController: _textController,
            onAttachmentPressed: () {},
            onSendPressed: () {},
          ),
        ],
      ),
    );
  }
}
