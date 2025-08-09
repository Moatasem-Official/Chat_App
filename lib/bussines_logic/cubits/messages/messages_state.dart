part of 'messages_cubit.dart';

sealed class MessagesState extends Equatable {
  const MessagesState();

  @override
  List<Object> get props => [];
}

final class MessagesCubitInitial extends MessagesState {}

final class MessagesCubitLoading extends MessagesState {}

final class MessagesCubitLoaded extends MessagesState {
  final List<MessageModel> messages;
  const MessagesCubitLoaded(this.messages);

  @override
  List<Object> get props => [messages];
}

final class MessageActionCubitError extends MessagesState {
  final String message;
  const MessageActionCubitError(this.message);

  @override
  List<Object> get props => [message];
}

final class MessagesCubitError extends MessagesState {
  final String message;
  const MessagesCubitError(this.message);

  @override
  List<Object> get props => [message];
}
