
class ChatUsers{
  String name;
  String message;
  String imagelink;
  String time;

  ChatUsers({required this.name, required this.message, required this.imagelink, required this.time});
}

  List<ChatUsers> chatUsers = [
    ChatUsers( name: "Jane Russel",  message: "Awesome Setup",  imagelink: "images/userImage1.jpeg", time: "Now"),
    ChatUsers( name: "Glady's Murphy",  message: "That's Great",  imagelink: "images/userImage2.jpeg",  time: "Yesterday"),
    ChatUsers( name: "Jorge Henry",  message: "Hey where are you?",  imagelink: "images/userImage3.jpeg",  time: "31 Mar"),
    ChatUsers( name: "Philip Fox",  message: "Busy! Call me in 20 mins",  imagelink: "images/userImage4.jpeg", time: "28 Mar"),
    ChatUsers( name: "Debra Hawkins",  message: "Thankyou, It's awesome",  imagelink: "images/userImage5.jpeg",  time: "23 Mar"),
    ChatUsers( name: "Jacob Pena",  message: "will update you in evening",  imagelink: "images/userImage6.jpeg", time: "17 Mar"),
    ChatUsers( name: "Andrey Jones",  message: "Can you please share the file?",  imagelink: "images/userImage7.jpeg", time: "24 Feb"),
    ChatUsers( name: "John Wick",  message: "How are you?",  imagelink: "images/userImage8.jpeg",  time: "18 Feb"),
  ];

