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
        child: RichText(
          text:  TextSpan(
            text: "Text",
            style: const TextStyle(
              fontSize: 60,
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.double,
              decorationColor: Colors.blueAccent,
            ),
            children: <TextSpan>[
              TextSpan(
                text: " Content".toUpperCase(),
                style: const TextStyle(
                  color: Colors.limeAccent,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.lineThrough,
                  decorationColor: Colors.purple,
                  decorationStyle: TextDecorationStyle.wavy,
                  decorationThickness: 3,
                ),
              )
            ],
          ),
        ),
       
      ),
    );
  }
}
