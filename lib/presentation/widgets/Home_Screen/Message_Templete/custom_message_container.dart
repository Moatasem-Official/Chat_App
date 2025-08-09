import 'package:chat_app/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class CustomMessageContainer extends StatelessWidget {
  const CustomMessageContainer({
    super.key,
    required this.message,
    required this.isSentByMe,
    required this.time,
    required this.wasEdited,
    required this.bubbleColor,
    required this.alignment,
    required this.textColor,
  });

  final String message;
  final bool isSentByMe;
  final DateTime time;
  final bool wasEdited;
  final BoxDecoration bubbleColor;
  final CrossAxisAlignment alignment;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              message,
              style: TextStyle(color: textColor, fontSize: 16),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: isSentByMe
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              wasEdited
                  ? Text(
                      'Edited',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                      ),
                    )
                  : const SizedBox.shrink(),
              const SizedBox(width: 16),
              Text(
                formatDateTime(time),
                style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
              ),
              const SizedBox(width: 8),
              if (isSentByMe)
                Icon(Icons.check_circle, color: Colors.green, size: 16),
            ],
          ),
        ],
      ),
    );
  }
}
