import 'package:flutter/material.dart';
import 'package:list/screens/welcomescreen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
      theme: ThemeData.dark(),
    );
  }
}

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController _textInputController1 = TextEditingController();
  TextEditingController _textInputController2 = TextEditingController();
  List<String> entries = [];
  List<String> qant = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              setState(() {
                _textInputController1.clear();
                _textInputController2.clear();
                add_new_item();
              });
            }),
        appBar: AppBar(
          title: Text("Shopping List"),
        ),
        body: liste());
  }

  add_new_item() {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
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
                    textField("item", _textInputController1),
                    SizedBox(
                      height: 20,
                    ),
                    textField("Quantity", _textInputController2),
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
                              setState(() {
                                entries.add(_textInputController1.text);
                                qant.add(_textInputController2.text);
                                _textInputController1.clear();
                                _textInputController2.clear();
                              });
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
    }));
  }

  TextField textField(text, controlling) {
    return TextField(
      controller: controlling,
      decoration: InputDecoration(
        labelText: text,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    );
  }

  liste() {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                height: 70,

                // color: Colors.lightBlue,
                child: FlatButton(
                  color: Colors.tealAccent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '${entries[index]}',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      Text('${qant[index]}',
                          style: TextStyle(color: Colors.black, fontSize: 20))
                    ],
                  ),
                  onPressed: () {
                    setState(() {
                      entries.removeAt(index);
                      qant.removeAt(index);
                    });
                  },
                ),
              ),
              SizedBox(
                height: 5,
              )
            ],
          );
        });
  }
}
