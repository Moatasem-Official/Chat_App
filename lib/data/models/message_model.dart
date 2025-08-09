class MessageModel {
  final String id;
  final String messageId;
  final String text;
  final DateTime time;
  final bool isSentByMe;

  MessageModel({
    required this.id,
    required this.messageId,
    required this.text,
    required this.time,
    required this.isSentByMe,
  });
}
