class Message{
  String content;
  String type;
  Message({required this.content, required this.type});
}


List<Message> messages = [
    Message(content: "Hello, Will", type: "receiver"),
    Message(content: "How have you been?", type: "receiver"),
    Message(content: "Hey Kriss, I am doing fine dude. wbu?", type: "sender"),
    Message(content: "ehhhh, doing OK.", type: "receiver"),
    Message(content: "Is there any thing wrong?", type: "sender"),
  ];