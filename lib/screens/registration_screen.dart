import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:my_chat_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_chat_app/screens/chat_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200,
                    child: Image.asset("images/logoApp.png"),
                  ),
                ),
              ),
              SizedBox(
                height: 48,
              ),
              MyTextFieldWidget(
                isPassword: false,
                onChanged: (value) {
                  email = value;
                },
                myHintText: 'Enter your email/username',
              ),
              SizedBox(
                height: 8,
              ),
              MyTextFieldWidget(
                isPassword: true,
                onChanged: (value) {
                  password = value;
                },
                myHintText: 'Enter your password',
              ),
              SizedBox(
                height: 24,
              ),
              RoundedButton(
                myText: "Register",
                myColor: Colors.blueAccent,
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if (newUser != null) {
                      Navigator.pushNamed(context, chatScreen.id);
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
