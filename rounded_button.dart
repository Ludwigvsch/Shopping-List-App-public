import 'package:flutter/material.dart';


class RoundedButtons extends StatelessWidget {

  RoundedButtons({this.buttonColor, this.label, @required this.onPressed});
  final Color buttonColor;
  final String label;
  final Function onPressed;



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: buttonColor,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
            //Go to login screen.
          
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            label,
          ),
        ),
      ),
    );
  }
}
