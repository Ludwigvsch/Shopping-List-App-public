import 'package:flutter/material.dart';
import'package:list/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:list/components/rounded_button.dart';
import 'package:list/screens/list_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:list/screens/welcomescreen.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign up')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            decoration: kTextFieldDecoration.copyWith(hintText: 'Sign up with email'),
            keyboardType: TextInputType.emailAddress,
            textAlign: TextAlign.center,
            onChanged: (value) {
              email = value;
            },
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            obscureText: true,
            decoration: kTextFieldDecoration.copyWith(hintText: 'Sign up with password'),
            keyboardType: TextInputType.emailAddress,
            textAlign: TextAlign.center,
            onChanged: (value) {
              password = value;
            },
          ),
          RoundedButtons(buttonColor: Colors.teal, onPressed: () async{
            try{
              final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
              if (newUser != null) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
              }
            } catch (e) {
              _onAlertButtonPressed(context);
            }
          }, label: 'Sign up')
        ],
      ),
    );
    
  }
  _onAlertButtonPressed(context) {
    Alert(
      context: context,
      type: AlertType.error,
      style: AlertStyle(
          titleStyle: TextStyle(
            color: Colors.white,
          ),
          descStyle: TextStyle(color: Colors.white)),
      title: "Error",
      desc: "Try using another Email or Password.",
      buttons: [
        DialogButton(
          color: Colors.blue,
          child: Text(
            "Ok",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }
}
