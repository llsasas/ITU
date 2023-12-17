import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ituapp/BE/Users.dart';
import '../auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllername = TextEditingController();
  final TextEditingController _controllersurname = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
      User? user = FirebaseAuth.instance.currentUser;

      await user?.updateDisplayName(_controllerUsername.text);

    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);

      User? user = FirebaseAuth.instance.currentUser;

      await user?.updateDisplayName(_controllerUsername.text);

      
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> add_userinfo() async {
    appusers.add(AppUsers(
        email: _controllerEmail.text,
        username: _controllerUsername.text,
        name: _controllername.text,
        surname: _controllersurname.text));
  }

  Widget _title() {
    return const Text(
      "Authentication",
      style: TextStyle(color: Colors.white),
    );
  }

  Widget _entryField(
    String title,
    TextEditingController controller,
  ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: title),
    );
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : '$errorMessage');
  }

  Widget _submitButton() {
    return ElevatedButton(
        style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
      ),
        onPressed: () {
          
          if (isLogin) {
            signInWithEmailAndPassword();
          } else {
            createUserWithEmailAndPassword();
            add_userinfo();
            
          }
        },
        child: Text(isLogin ? 'Login' : 'Register',style: TextStyle(color: Colors.black)));
  }

  Widget _loginOrRegister() {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
      ),
      onPressed: () {
        setState(() {
          isLogin = !isLogin;
        });
      },
      // ignore: prefer_const_constructors
      //style: ButtonStyle(backgroundColor: Colors.red),
      child: Text(
        isLogin! ? 'Register instead' : 'Login instead',
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title(),
        backgroundColor: Colors.redAccent.shade700,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _entryField('Email', _controllerEmail),
            if (!isLogin) _entryField('Username', _controllerUsername),
            if (!isLogin) _entryField('Name', _controllername),
            if (!isLogin) _entryField('Surname', _controllersurname),
            _entryField('Password', _controllerPassword),
            _errorMessage(),
            _submitButton(),
            _loginOrRegister(),
          ],
        ),
      ),
    );
  }
}
