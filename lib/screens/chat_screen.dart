import 'package:flutter/material.dart';
import 'package:my_chat_app/constants.dart';
import 'package:my_chat_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_chat_app/screens/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _fireStore = FirebaseFirestore.instance;
late User loggedInUser;
final _auth = FirebaseAuth.instance;

class chatScreen extends StatefulWidget {
  static String id = 'chat_screen';
  @override
  _chatScreenState createState() => _chatScreenState();
}

class _chatScreenState extends State<chatScreen> {
  String messageText = '';
  final MessageTextController = TextEditingController();

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        //print(loggedInUser.email);
        //print(loggedInUser.)
      }
    } catch (e) {
      print(e);
    }
  }

  // void getMessages() async{
  //   final messages = await _fireStore.collection('msg').get();
  //   for(var txt in messages.docs)
  //     {
  //       print(txt.data());
  //     }
  // }

  void messagesStream() async {
    await for (var snapshot in _fireStore.collection('msg').snapshots()) {
      for (var mess in snapshot.docs) {
        print(mess.data());
      }
    }
  }

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              //log out proseccing
              _auth.signOut();
              Navigator.pushNamed(context, WelcomeScreen.id);
              // messagesStream();
            },
            icon: Icon(Icons.close),
          ),
        ],
        title: Text('FChat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: MessageTextController,
                      style: TextStyle(color: Colors.black54),
                      onChanged: (value) {
                        //do something with user input
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        //send message
                        MessageTextController.clear();
                        setState(() {
                          _fireStore.collection('msg').add({
                            'text': messageText,
                            'sender': loggedInUser.email,
                          });
                        });
                      },
                      child: Text(
                        'Send',
                        style: kSendButtonTextStyle,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String? mes;
  final String? sender;
  bool? isMe;
  MessageBubble({this.mes, this.sender, this.isMe});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Material(
            borderRadius: isMe!
                ? BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5))
                : BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
            color: isMe! ? Colors.lightBlueAccent : Colors.grey[500],
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                mes!,
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Text(
            sender!,
            style: TextStyle(color: Colors.grey[400], fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _fireStore.collection('msg').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlue,
              ),
            );
          }
          final messages = snapshot.data?.docs.reversed;
          List<Widget> messagesBubbles = [];
          for (var masage in messages!) {
            final messageText = masage.data().toString().contains('text')
                ? masage.get('text')
                : '404';
            // final messageSender = masage.get('sender');
            final messageSender = masage.data().toString().contains('sender')
                ? masage.get('sender')
                : '404';

            final currentUser = loggedInUser.email;
            final messageBubble = MessageBubble(
              mes: messageText.toString(),
              sender: messageSender.toString(),
              isMe: currentUser == messageSender,
            );
            messagesBubbles.add(messageBubble);
          }

          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              children: messagesBubbles,
            ),
          );
        });
  }
}
