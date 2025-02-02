import 'package:flutter/material.dart';
import 'package:yes_no_app/config/helpers/get_yes_no_answer.dart';
import 'package:yes_no_app/domain/entities/message.dart';

class ChatProvider extends ChangeNotifier{
  final ScrollController chatScrollController = ScrollController();
  final GetYesNoAnswer getYesNoAnswer =  GetYesNoAnswer();
List<Message> messageList = [
  Message(text: 'hola', fromWho: FromWho.me),
  Message(text: 'Ya regresaste del trabajo?', fromWho: FromWho.me),
];
Future<void> herReply() async{
  final herMessage = await getYesNoAnswer.getAnswer();
  messageList.add(herMessage);
}
Future<void> sendMessage(String text) async{
  if(text.isEmpty)return;
  //todo: implementar
  final newMessage = Message(text: text, fromWho: FromWho.me);
  
  messageList.add(newMessage);
  if(text.trim().endsWith('?')){
    await herReply();
  }
  notifyListeners();//para que se actualice
  moveScrollToBottom();
}
void moveScrollToBottom() async{
  await Future.delayed(const Duration(milliseconds: 100));
  chatScrollController.animateTo(
    chatScrollController.position.maxScrollExtent, //calcula la pocicion final
    duration: const Duration(milliseconds: 300),
     curve: Curves.easeOut
     );
}
}