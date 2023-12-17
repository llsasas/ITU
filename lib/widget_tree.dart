/*
  Author: Jan Hranička - xhrani03
  Date: December 17, 2023
*/
import 'package:flutter/material.dart';
import 'package:ituapp/pages/register_page.dart';
import 'package:ituapp/pages/home.dart';
import 'package:ituapp/auth.dart';

class WidgetTree extends StatefulWidget
{
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree>
{
  @override
  Widget build(BuildContext context)
  {
    return StreamBuilder(stream: Auth().authStateChanges,
     builder: (context, snapshot) {
       if(snapshot.hasData)
       {
        return const HomeScreen();
       }
       else{
        return const LoginPage();
       }
     },);
  }
}