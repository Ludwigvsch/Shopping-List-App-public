import 'package:flutter/material.dart';
import 'package:list/components/rounded_button.dart';
import 'package:list/screens/SigninPage.dart';
import 'package:list/screens/SignupPage.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome to the Shopping List")
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
        
          
          children: [
            RoundedButtons(buttonColor: Colors.teal,onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => SigninPage()));}, label: "Sign in"),
            RoundedButtons(buttonColor: Colors.teal, onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));}, label: "Sign up"),
            
        ],),
      ),
      
      
    );
  }
}