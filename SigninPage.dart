import 'package:flutter/material.dart';
import 'package:list/constants.dart';
import 'package:list/screens/list_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:list/components/rounded_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

FirebaseAuth _auth = FirebaseAuth.instance;



class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  Future<FirebaseUser> getUser() async {
    return await _auth.currentUser();
  }
  @override
  void initState() {
    super.initState();
    getUser().then((user) {
      if (user != null) {
        Navigator.push(context,
          MaterialPageRoute(builder: (context) => MainPage()));
      }
    });
  }

  bool showspinner = false;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),),
        

        
      
      body: ModalProgressHUD(
        inAsyncCall: showspinner,
              child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: kTextFieldDecoration.copyWith(hintText: 'Sign in with email'),
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
              decoration: kTextFieldDecoration.copyWith(hintText: 'Sign in with password'),
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                password = value;
              },
            ),
            RoundedButtons(buttonColor: Colors.teal, onPressed: () async{
              try{
                setState(() {
                  showspinner = true;
                });
                final newUser = await _auth.signInWithEmailAndPassword(email: email, password: password);
                if (newUser != null) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
                }
                setState(() {
                  showspinner = false;
                });
              } catch (e) {
                _onAlertButtonPressed(context);
              }
            }, label: 'Sign in')
          ],
        ),
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