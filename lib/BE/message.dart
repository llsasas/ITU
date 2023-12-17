/*
  Author: Jan Hranička - xhrani03
  Date: December 17, 2023
  Description: This is a Flutter source file for Class representing chat users, BE
*/
class Message{
  String content;
  String type;
  Message({required this.content, required this.type});
}


List<Message> messages = [
    Message(content: "Hey mate", type: "receiver"),
    Message(content: "How have you been?", type: "receiver"),
    Message(content: "Hey Jane, I am doing fine dude. wbu?", type: "sender"),
    Message(content: "ehhhh, doing OK.", type: "receiver"),
    Message(content: "Is there anything wrong?", type: "sender"),
    Message(content: "You crashed my car!", type: "receiver"),
  ];