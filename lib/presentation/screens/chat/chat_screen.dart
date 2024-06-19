import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_no_app/domain/entities/message.dart';
import 'package:yes_no_app/presentation/providers/chat_provider.dart';
import 'package:yes_no_app/presentation/widgets/chat/her_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/chat/my_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/chat/shared/message_field_box.dart'; //importm
class ChatScreen extends StatelessWidget {//stless
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage('https://scontent-lim1-1.xx.fbcdn.net/v/t39.30808-6/434735635_1863263150800284_7554170972405464460_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=5f2048&_nc_eui2=AeECtGWw1J8--yQxEAtPHvcMYgAZzRuPGo9iABnNG48aj0-egNO3fsNgIMi9FoAsEiPpvuxlcnspGKszi_5SAeRh&_nc_ohc=XfXV-Zg-o8kQ7kNvgGLRpxR&_nc_ht=scontent-lim1-1.xx&oh=00_AYB0ymGIkaxTfvEdGCif0gdsnwlO19d0rb-MfgA0iXwOtA&oe=6677C959'),
          ),
        ),
        title: const Text('Mi amor ♥'),
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
          children:[
            Expanded(
              child: ListView.builder(
                controller: chatProvider.chatScrollController,
                itemCount: chatProvider.messageList.length,
                itemBuilder: (context, index) {//como un for
                final message = chatProvider.messageList[index];
                return(message.fromWho==FromWho.hers)?
                HerMessageBubble(message: message,):
                MyMessageBubble(message:message);
              },)  //con esto se crean bajo demanda
                ),
            //caja de texto
            MessageFieldBox(
              onValue: chatProvider.sendMessage,//funcionar como event emitter
            ),
          ]
          ),
      ),
    );
  }
}