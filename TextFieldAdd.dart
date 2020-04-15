import 'package:flutter/material.dart';


class TextFieldAddPage extends StatelessWidget {
  const TextFieldAddPage({this.text, this.controlling, this.onchanged});

  final String text;
  final TextEditingController controlling;
  final Function onchanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onchanged,
      controller: controlling,
      decoration: InputDecoration(
        labelText: text,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    );
  }
}
