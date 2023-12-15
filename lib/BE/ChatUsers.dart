import 'package:flutter/cupertino.dart';

class Users{
  String name;
  String message;
  String imagelink;
  String time;

  Users({required this.name, required this.message, required this.imagelink, required this.time});
}

  List<Users> chatUsers = [
    Users( name: "Jane Russel",  message: "Awesome Setup",  imagelink: "images/userImage1.jpeg", time: "Now"),
    Users( name: "Glady's Murphy",  message: "That's Great",  imagelink: "images/userImage2.jpeg",  time: "Yesterday"),
    Users( name: "Jorge Henry",  message: "Hey where are you?",  imagelink: "images/userImage3.jpeg",  time: "31 Mar"),
    Users( name: "Philip Fox",  message: "Busy! Call me in 20 mins",  imagelink: "images/userImage4.jpeg", time: "28 Mar"),
    Users( name: "Debra Hawkins",  message: "Thankyou, It's awesome",  imagelink: "images/userImage5.jpeg",  time: "23 Mar"),
    Users( name: "Jacob Pena",  message: "will update you in evening",  imagelink: "images/userImage6.jpeg", time: "17 Mar"),
    Users( name: "Andrey Jones",  message: "Can you please share the file?",  imagelink: "images/userImage7.jpeg", time: "24 Feb"),
    Users( name: "John Wick",  message: "How are you?",  imagelink: "images/userImage8.jpeg",  time: "18 Feb"),
  ];