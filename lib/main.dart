import 'package:flutter/material.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext build) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Teste"),
          elevation: 0,
        ),
        body: Text("Teste"),
      ),
    );
  }
}
