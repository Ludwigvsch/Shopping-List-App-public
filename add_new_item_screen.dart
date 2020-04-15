import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:list/components/TextFieldAdd.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedinUser;

class Addnewitem extends StatefulWidget {
  @override
  _AddnewitemState createState() => _AddnewitemState();
}

class _AddnewitemState extends State<Addnewitem> {
  TextEditingController _textInputController1 = TextEditingController();
  TextEditingController _textInputController2 = TextEditingController();
  String item;
  String quant;
  String email;

  void initState() {
    super.initState();
    getCurrentUser();
  }

  final _auth = FirebaseAuth.instance;

  void getCurrentUser() async {
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
        appBar: AppBar(
          title: Text("Add Items"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: Center(
          child: Container(
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextFieldAddPage(
                      text: "item",
                      controlling: _textInputController1,
                      onchanged: (value) {
                        item = value;
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  TextFieldAddPage(
                      text: "Quantity",
                      controlling: _textInputController2,
                      onchanged: (value) {
                        quant = value;
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                          color: Colors.tealAccent,
                          child: Text(
                            "Submit",
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            DocumentReference new_item = _firestore
                                .collection('users')
                                .document(loggedinUser.uid)
                                .collection('items')
                                .document();

                            new_item.setData({
                              'email': loggedinUser.email,
                              'item': item,
                              'quant': quant,
                            });

                            _textInputController1.clear();
                            _textInputController2.clear();
                          }),
                      SizedBox(
                        width: 10,
                      ),
                      RaisedButton(
                        color: Colors.tealAccent,
                        child: Text("Cancel",
                            style: TextStyle(color: Colors.black)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  )
                ],
              )),
        ));
  }
}


