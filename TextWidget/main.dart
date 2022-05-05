import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter app',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const MyHomePage(title: 'Text Widget'),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
     appBar: AppBar(
       title: Text(widget.title),
       backgroundColor: Colors.transparent,
     ),
      body:  Center(
      
        child: Text(
            "Text Content".toUpperCase(),
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: Colors.white, fontSize: 50,
            fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          backgroundColor: Colors.brown,
          wordSpacing: 8,
          decoration: TextDecoration.underline,
          decorationStyle: TextDecorationStyle.wavy,
          decorationColor: Colors.blue,
          decorationThickness: 2,
        ),
        ),
    
      ),
    );
  }
}
