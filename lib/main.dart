import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/login_screen.dart';
import 'screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main()async{
  //the WidgetFlutterBinding is used to interact with the Flutter engine.
  WidgetsFlutterBinding.ensureInitialized();

  //Firebase.initializeApp() needs to call native code to initialize Firebase,
  // and since the plugin needs to use platform channels to call the native code,
  // which is done asynchronously therefore you have to call ensureInitialized()
  // to make sure that you have an instance of the WidgetsBinding.
  await Firebase.initializeApp();

  runApp(FlashChat());
}


class FlashChat extends StatelessWidget
{

  @override
  Widget build (BuildContext context)
  {
    return  MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.black54),
        ),
      ),
      initialRoute:WelcomeScreen.id,
      routes: {
        WelcomeScreen.id:(context)=>WelcomeScreen(),
        LoginScreen.id:(context)=>LoginScreen(),
        RegistrationScreen.id:(context)=>RegistrationScreen(),
        chatScreen.id:(context)=>chatScreen(),
      },
    );
  }
}

