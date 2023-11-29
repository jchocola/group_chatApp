import 'package:flutter/material.dart';

const kSendButtonTextStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 18,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
  hintText: 'Type your message here...',
  hintStyle: TextStyle(color: Colors.black54),
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
      top: BorderSide(
    color: Colors.lightBlueAccent,
    width: 2,
  )),
);

class RoundedButton extends StatelessWidget {
  String myText;
  Color myColor;
  // VoidCallbackAction ?myFunc;
  final void Function()? onPressed;
  RoundedButton({this.myText = '', this.myColor = Colors.red, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Material(
        elevation: 5,
        color: myColor,
        borderRadius: BorderRadius.circular(30),
        child: MaterialButton(
          onPressed: onPressed,
          child: Text("$myText"),
          minWidth: 200,
          height: 42,
        ),
      ),
    );
  }
}

class MyTextFieldWidget extends StatelessWidget {
  String? myHintText ;
  bool? isPassword = false;
  final void Function(String) ?onChanged;
  MyTextFieldWidget({this.myHintText,this.onChanged,this.isPassword});
  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.center,
      obscureText: isPassword!,
      onChanged: onChanged,
      style: TextStyle(color: Colors.black54),
      decoration: InputDecoration(
        hintText: myHintText,
        hintStyle: TextStyle(color: Colors.black54),
        contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1),
          borderRadius: BorderRadius.circular(32),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1),
          borderRadius: BorderRadius.circular(32),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide(
            color: Colors.blueAccent, width: 2,),
        ),
      ),
    );
  }
}
