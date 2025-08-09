import 'package:chat_app/data/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  static Future<void> addMessage(String message) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    // إنشاء document جديد للحصول على الـ id قبل الحفظ
    final docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('messages')
        .doc();

    await docRef.set({
      'id': docRef.id, // نخزن الـ id هنا
      'message': message,
      'sendedAt': DateTime.now(),
      'messageId': FirebaseAuth.instance.currentUser!.email, // نخزن الـ id هنا
    });
  }

  static Stream<List<MessageModel>> getMessages() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('messages')
        .orderBy('sendedAt', descending: false)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            final sendedAt = doc['sendedAt'];

            DateTime time;
            if (sendedAt is Timestamp) {
              time = sendedAt.toDate();
            } else if (sendedAt is int) {
              time = DateTime.fromMillisecondsSinceEpoch(sendedAt);
            } else {
              time = DateTime.now(); // fallback لو مفيش تاريخ
            }

            return MessageModel(
              id:
                  doc['id'] ??
                  doc.id, // استخدام id من الـ document أو id من الـ doc
              text: doc['message'] ?? '',
              isSentByMe:
                  FirebaseAuth.instance.currentUser!.email == doc['messageId']
                  ? true
                  : false,
              time: time,
              messageId: doc['messageId'] ?? '', // إضافة messageId
            );
          }).toList();
        });
  }

  static Future<void> deleteMessage(String messageId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('messages')
        .doc(messageId)
        .delete();
  }

  static Future<void> updateMessage(String messageId, String message) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('messages')
        .doc(messageId)
        .update({'message': message});
  }

  static Future<void> deleteAllMessages() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('messages')
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach((doc) => doc.reference.delete()),
        );
  }

  static Future<void> addUserInfo({
    required String name,
    required String email,
  }) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({'name': name, 'email': email});
  }
}
