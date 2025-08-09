import 'package:chat_app/bussines_logic/cubits/messages/messages_cubit.dart';
import 'package:chat_app/data/models/message_model.dart';
import 'package:chat_app/presentation/widgets/Home_Screen/Message_Templete/custom_message_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomMessageTemplete extends StatefulWidget {
  const CustomMessageTemplete({super.key, required this.message});

  final MessageModel message;

  @override
  State<CustomMessageTemplete> createState() => _CustomMessageTempleteState();
}

class _CustomMessageTempleteState extends State<CustomMessageTemplete> {
  bool wasEdited = false;

  @override
  Widget build(BuildContext context) {
    final alignment = widget.message.isSentByMe
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start;
    final bubbleColor = widget.message.isSentByMe
        ? const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF8E9EFE), Color(0xFFAB87FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(0),
            ),
          )
        : const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(0),
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          );
    final textColor = widget.message.isSentByMe ? Colors.white : Colors.black87;

    return GestureDetector(
      onTap: () {
        if (widget.message.isSentByMe) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: Text('Do you want to delete this message ?'),
              actions: [
                TextButton(
                  onPressed: () {
                    BlocProvider.of<MessagesCubit>(
                      context,
                    ).deleteMessage(widget.message.id);
                    Navigator.of(context).pop();
                  },
                  child: const Text('Delete'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    showDialog(
                      context: context,
                      builder: (context) {
                        final textController = TextEditingController(
                          text: widget.message.text,
                        );
                        return AlertDialog(
                          title: const Text('Edit Message'),
                          content: TextField(
                            controller: textController,
                            decoration: const InputDecoration(
                              hintText: 'Edit your message',
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                if (textController.text.isNotEmpty) {
                                  BlocProvider.of<MessagesCubit>(
                                    context,
                                  ).updateMessage(
                                    widget.message.id,
                                    textController.text,
                                  );
                                  Navigator.of(context).pop();
                                }
                                setState(() {
                                  wasEdited = true;
                                });
                              },
                              child: const Text('Save'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text('Edit'),
                ),
              ],
            ),
          );
        }
      },
      child: CustomMessageContainer(
        message: widget.message.text,
        isSentByMe: widget.message.isSentByMe,
        time: widget.message.time,
        wasEdited: wasEdited,
        bubbleColor: bubbleColor,
        alignment: alignment,
        textColor: textColor,
      ),
    );
  }
}
