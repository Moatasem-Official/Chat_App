import 'package:flutter/material.dart';

class CustomMessageComposer extends StatelessWidget {
  const CustomMessageComposer({
    super.key,
    required this.textController,
    required this.onSendPressed,
    required this.onAttachmentPressed,
  });

  final TextEditingController textController;
  final Function() onSendPressed;
  final Function() onAttachmentPressed;

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
              onPressed: onSendPressed,
            ),
          ],
        ),
      ),
    );
  }
}
