import 'package:bloc/bloc.dart';
import 'package:chat_app/data/models/message_model.dart';
import 'package:chat_app/data/services/firebase/firestore/firestore_service.dart';
import 'package:equatable/equatable.dart';

part 'messages_state.dart';

class MessagesCubit extends Cubit<MessagesState> {
  MessagesCubit() : super(MessagesCubitInitial());

  Future<void> addMessage(String message) async {
    try {
      await FirestoreService.addMessage(message);
    } catch (e) {
      emit(MessagesCubitError(e.toString()));
    }
  }

  Future<void> deleteMessage(String messageId) async {
    try {
      await FirestoreService.deleteMessage(messageId);
    } catch (e) {
      emit(MessagesCubitError(e.toString()));
    }
  }

  Future<void> updateMessage(String messageId, String message) async {
    try {
      await FirestoreService.updateMessage(messageId, message);
    } catch (e) {
      emit(MessagesCubitError(e.toString()));
    }
  }

  Future<void> deleteAllMessages() async {
    try {
      await FirestoreService.deleteAllMessages();
    } catch (e) {
      emit(MessagesCubitError(e.toString()));
    }
  }

  void listenToMessages() {
    emit(MessagesCubitLoading());
    FirestoreService.getMessages().listen(
      (messages) {
        emit(MessagesCubitLoaded(messages));
      },
      onError: (e) {
        emit(MessagesCubitError(e.toString()));
      },
    );
  }
}
