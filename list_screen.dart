import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:list/screens/add_new_item_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedinUser;

Future<void> _fetchdata;

FirebaseAuth _auth = FirebaseAuth.instance;

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  void initState() {
    super.initState();

    _fetchdata = getCurrentUser();
  }

  Future<void> getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedinUser = user;
        // print(loggedinUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Addnewitem()));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        leading: Container(),
        title: Text("Shopping List"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                // messagesStream();
                _auth.signOut();
                Navigator.pop(context);
              })
        ],
      ),
      body: SafeArea(
        child: MessagesStream(),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchdata,
      builder: (context, myFuture) {
        if (myFuture.connectionState == ConnectionState.done &&
            !myFuture.hasError) {
          return StreamBuilder<QuerySnapshot>(
            stream: _firestore
                .collection('users')
                .document(loggedinUser.uid)
                .collection('items')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData ||
                  snapshot.hasError ||
                  snapshot.data == null ||
                  snapshot.connectionState == ConnectionState.waiting ||
                  loggedinUser.email == null) {
                return (Center(
                    child: CircularProgressIndicator(
                        backgroundColor: Colors.blue)));
              }
              final items = snapshot.data.documents.reversed;
              List<MessageBubble> messageBubbles = [];
              for (var message in items) {
                final item = message.data['item'];
                final sender = message.data['email'];
                final quant = message.data['quant'];

                // final currentUser = loggedinUser.email;

                final messageBubble = MessageBubble(
                  text: item,
                  quant: quant,
                  documentReference: message.reference,
                );

                messageBubbles.add(messageBubble);
              }

              return ListView(
                // reverse: true,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                children: messageBubbles,
              );
            },
          );
        } else {
          return CupertinoActivityIndicator();
        }
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.text, this.quant, this.documentReference});

  final String text;
  final String quant;
  final DocumentReference documentReference;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: Colors.tealAccent,
            child: FlatButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    text,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  Text(quant,
                      style: TextStyle(color: Colors.black, fontSize: 20))
                ],
              ),
              onPressed: () {
                documentReference.delete();
              },
            ),
          ),
        )
      ],
    );
  }
}
