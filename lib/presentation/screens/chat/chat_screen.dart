//importM

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_no_app/domain/entities/message.dart';
import 'package:yes_no_app/presentation/widgets/chat/her_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/chat/my_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/shared/message_field_box.dart';

import '../../providers/chat_provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(4.0),
          child: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTI9ifWgHEerOEYhVP20INWQxYDRZv_h4fCyw&usqp=CAU')),
        ),
        title: const Text('Comics chat'),
        centerTitle: false,
      ),
      body: _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                  controller: chatProvider.chatScrollController,
                  itemCount: chatProvider.messagesList.length,
                  itemBuilder: (context, index) {
                  final  message = chatProvider.messagesList[index];
                  return (message.fromWho == FromWho.hers)
                      ?  HerMessageBubble(message:message)
                      :  MyMessageBubble(message:message);
              },
            )),
            //Caja de texto de mensajes.
            MessageFieldBox(
              // onValueChanged: (value)=>chatProvider.sendMessage(value),
              onValueChanged: chatProvider.sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}
