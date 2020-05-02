import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final int a = 5;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      title: 'Flutter Demo $a',
      home: MyHomePage(title: 'Flutter Demo Home Page $a'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    print("merhaba");
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Column(
              children: <Widget>[
                MyWidget(),
                MyOtherWidget(),
                Sayac(15)
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      )
    );
  }
}

class Sayac extends StatefulWidget {
  final int ilkDeger;

  Sayac(this.ilkDeger);

  @override
  _SayacState createState() => _SayacState();
}

class _SayacState extends State<Sayac> {
  int kacKere = 0;

  @override
  void initState() {
    super.initState();
    kacKere = widget.ilkDeger;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.ilkDeger);

    return Column(
      children: <Widget>[
        RaisedButton(
          child: Text("bu kadar bastın: $kacKere", textScaleFactor: 3.0,),
          onPressed: () {
            setState(() {
              kacKere += 1;
            });
            print("bastın");
          },
        ),
        RaisedButton(
          child: Text("ikinci sayfa"),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return SecondPage();
              },
            ));
          },
        )
      ],
    );
  }
}

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  String title = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ikinci sayfa")
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              left: 8,
              right: 8,
              bottom: 24,
              top: 8
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Icon(Icons.person)
                ),
                Expanded(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text("username auo eu aeo u ao eu aoe u eaoueaou oeu", textScaleFactor: 2)
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Text("ikinci sayfa burası $index!", textScaleFactor: 2,);
              },
            )
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(child: Text(title, textScaleFactor: 3,)),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () async {
                    http.Response response = await http.get('https://jsonplaceholder.typicode.com/albums/1');

                    var decode = json.decode(response.body);

                    print(decode["title"]);

                    setState(() {
                      title = decode["title"];
                    });
                  },
                )
              ],
            ),
          ),
        ],
      )
    );
  }
}

class MyOtherWidget extends StatefulWidget {
  @override
  _MyOtherWidgetState createState() => _MyOtherWidgetState();
}

class _MyOtherWidgetState extends State<MyOtherWidget> {
  @override
  Widget build(BuildContext context) {
    return Text("my other widget");
  }
}


class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("mywidget"),
    );
  }
}
