import 'package:chat_app/bussines_logic/cubits/messages/messages_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomMessageComposer extends StatelessWidget {
  const CustomMessageComposer({
    super.key,
    required this.textController,
    required this.onAttachmentPressed,
    required this.scrollController,
  });

  final TextEditingController textController;
  final Function() onAttachmentPressed;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.attach_file, color: Colors.teal.shade600),
              onPressed: onAttachmentPressed,
            ),
            Expanded(
              child: TextField(
                controller: textController,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Type a message...',
                ),
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
            IconButton(
              icon: Icon(Icons.send_rounded, color: Colors.teal.shade600),
              onPressed: () {
                if (textController.text.isNotEmpty) {
                  context.read<MessagesCubit>().addMessage(textController.text);
                  textController.clear();
                  scrollController.animateTo(
                    scrollController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
