import 'package:chat_app/data/models/message_model.dart';
import 'package:flutter/material.dart';

class ChatHomeScreen extends StatefulWidget {
  const ChatHomeScreen({super.key});

  @override
  State<ChatHomeScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ChatHomeScreen> {
  final TextEditingController _textController = TextEditingController();

  // بيانات وهمية للمحادثة
  final List<ChatMessage> _messages = [
    ChatMessage(
      text: "أهلاً يا صديقي، كيف حالك؟",
      time: "10:00 ص",
      isSentByMe: false,
    ),
    ChatMessage(
      text: "بخير الحمد لله، ماذا عنك؟",
      time: "10:01 ص",
      isSentByMe: true,
    ),
    ChatMessage(
      text: "كل شيء تمام. هل أنت مشغول اليوم؟",
      time: "10:01 ص",
      isSentByMe: true,
    ),
    ChatMessage(
      text: "ليس كثيرًا، هل هناك شيء؟",
      time: "10:03 ص",
      isSentByMe: false,
    ),
    ChatMessage(
      text: "كنت أفكر أن نتقابل لتناول القهوة ومناقشة المشروع الجديد. ما رأيك؟",
      time: "10:04 ص",
      isSentByMe: true,
    ),
    ChatMessage(
      text: "فكرة ممتازة! أنا متاح بعد الظهر.",
      time: "10:05 ص",
      isSentByMe: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9), // خلفية هادئة
      // 1. الشريط العلوي الذكي
      appBar: _buildAppBar(),
      body: Column(
        children: [
          // 2. قائمة الرسائل
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              reverse: false, // لعرض الرسائل من الأعلى للأسفل
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessageBubble(_messages[index]);
              },
            ),
          ),
          // 3. حقل إدخال النص
          _buildMessageComposer(),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      elevation: 1,
      title: Row(
        children: [
          CircleAvatar(
            backgroundImage: const AssetImage("assets/images/moatasem.jpg"),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Moatasem Nagy", // اسم الشخص الآخر
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "متصل الآن",
                style: TextStyle(color: Colors.green.shade600, fontSize: 13),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.videocam_outlined,
            color: Colors.black54,
            size: 28,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(
            Icons.call_outlined,
            color: Colors.black54,
            size: 26,
          ),
          onPressed: () {},
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    // تحديد محاذاة الرسالة بناءً على المرسل
    final alignment = message.isSentByMe
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start;
    // تحديد لون خلفية الرسالة
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
    // تحديد لون النص
    final textColor = message.isSentByMe ? Colors.white : Colors.black87;

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
              message.text,
              style: TextStyle(color: textColor, fontSize: 16),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            message.time,
            style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageComposer() {
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
              icon: Icon(Icons.attach_file, color: Colors.grey.shade600),
              onPressed: () {},
            ),
            Expanded(
              child: TextField(
                controller: _textController,
                decoration: const InputDecoration.collapsed(
                  hintText: "اكتب رسالتك...",
                ),
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
            IconButton(
              icon: Icon(Icons.send, color: Theme.of(context).primaryColor),
              onPressed: () {
                // منطق إرسال الرسالة
              },
            ),
          ],
        ),
      ),
    );
  }
}
