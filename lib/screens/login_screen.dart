import 'package:flutter/material.dart';
import 'package:my_chat_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_chat_app/screens/chat_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget
{
  static String id = 'login_screen';
  @override
  _LoginScreenState createState()=> _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
{
  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  bool showSpinner = false;
  @override
  Widget build (BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: false,
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
                    child: Image.asset('images/logoApp.png'),
                  ),
                ),
              ),
              SizedBox(height: 48,),

             MyTextFieldWidget(
               isPassword: false,
               myHintText: 'Enter your login',
               onChanged: (value){
                 email = value;
               },),

              SizedBox(height: 8,),

              MyTextFieldWidget(
                isPassword: true,
                myHintText:'Enter your password',
                onChanged: (value){
                  password = value;
                },),
              SizedBox(height: 24,),

              //BUTTON
              RoundedButton(
                myColor: Colors.lightBlueAccent,
                myText: 'Log in',
                onPressed: () {
                  setState(() {
                    showSpinner = true;
                  });
                  try{
                    final user = _auth.signInWithEmailAndPassword(email: email, password: password);

                    if(user != null)
                    {
                      Navigator.pushNamed(context, chatScreen.id);
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  }
                  catch(e)
                  {print(e);}
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}