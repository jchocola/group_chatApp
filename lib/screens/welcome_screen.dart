import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_app/constants.dart';
import 'package:my_chat_app/screens/login_screen.dart';
import 'package:my_chat_app/screens/registration_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin
{
  late AnimationController controler;
  late Animation animation;
  @override
  void initState() {
    super.initState();

    controler = AnimationController(
      upperBound: 1,
      duration: Duration(seconds: 2),
      vsync: this,
    );
    //animation = CurvedAnimation(parent: controler, curve: Curves.easeInBack);
    animation =
        ColorTween(begin: Colors.black, end: Colors.white).animate(controler);
    controler.forward();
    controler.addListener(() {
      setState(() {});
      print(animation.value);
    });
    // controler.addStatusListener((status) {
    //   if(status == AnimationStatus.completed)
    //     {
    //       controler.reverse(from:1);
    //     }
    //   else if(status == AnimationStatus.dismissed)
    //     {
    //       controler.forward();
    //     }
    // });
  }

  @override
  void dispose() {
    controler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      child: Image.asset("images/logoApp.png"),
                      height: 60,
                    ),
                  ),
                ),
                DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                  child: AnimatedTextKit(
                    pause: Duration(seconds: 2),
                    animatedTexts: [
                      TyperAnimatedText('Flash Chat'),
                    ],
                    //'${animation.value*100} %',
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48,
            ),
            RoundedButton(
              myText: "Log In",
              myColor: Colors.lightBlueAccent,
              onPressed: (){
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            RoundedButton(
              myText: 'Register',
              myColor: Colors.blueAccent,
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
