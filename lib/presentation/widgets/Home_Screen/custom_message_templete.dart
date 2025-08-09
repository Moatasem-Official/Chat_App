import 'package:chat_app/bussines_logic/cubits/messages/messages_cubit.dart';
import 'package:chat_app/data/models/message_model.dart';
import 'package:chat_app/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomMessageTemplete extends StatelessWidget {
  const CustomMessageTemplete({super.key, required this.message});

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    final alignment = message.isSentByMe
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start;
    final bubbleColor = message.isSentByMe
        ? const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF8E9EFE), Color(0xFFAB87FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          )
        : const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          );
    final textColor = message.isSentByMe ? Colors.white : Colors.black87;

    return GestureDetector(
      onTap: () {
        if (message.isSentByMe) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: Text('Do you want to delete this message ?'),
              actions: [
                TextButton(
                  onPressed: () {
                    BlocProvider.of<MessagesCubit>(
                      context,
                    ).deleteMessage(message.id);
                    Navigator.of(context).pop();
                  },
                  child: const Text('Delete'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
              ],
            ),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: alignment,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              decoration: bubbleColor,
              child: Text(
                message.text,
                style: TextStyle(color: textColor, fontSize: 16),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              formatDateTime(message.time),
              style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
