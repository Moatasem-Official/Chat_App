import 'package:chat_app/bussines_logic/cubits/messages/messages_cubit.dart';
import 'package:chat_app/presentation/widgets/Home_Screen/custom_app_bar.dart';
import 'package:chat_app/presentation/widgets/Home_Screen/custom_message_composer.dart';
import 'package:chat_app/presentation/widgets/Home_Screen/Message_Templete/custom_message_templete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ChatHomeScreen extends StatefulWidget {
  const ChatHomeScreen({super.key});

  @override
  State<ChatHomeScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ChatHomeScreen> {
  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: CustomAppBar(),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<MessagesCubit, MessagesState>(
              listener: (context, state) {
                if (state is MessagesCubitError) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              builder: (context, state) {
                return BlocBuilder<MessagesCubit, MessagesState>(
                  builder: (context, state) {
                    if (state is MessagesCubitLoaded) {
                      if (state.messages.isEmpty) {
                        return Center(
                          child: SvgPicture.asset(
                            "assets/images/Chat-cuate.svg",
                          ),
                        );
                      } else {
                        return ListView.builder(
                          padding: const EdgeInsets.all(16.0),
                          reverse: false,
                          itemCount: state.messages.length,
                          controller: _scrollController,
                          itemBuilder: (context, index) {
                            return CustomMessageTemplete(
                              message: state.messages[index],
                            );
                          },
                        );
                      }
                    } else if (state is MessagesCubitError) {
                      return Center(child: Text(state.message));
                    } else if (state is MessagesCubitLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return const Center(child: Text('Something went wrong'));
                    }
                  },
                );
              },
            ),
          ),
          CustomMessageComposer(
            scrollController: _scrollController,
            textController: _textController,
            onAttachmentPressed: () {},
          ),
        ],
      ),
    );
  }
}
