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
      home: const MyHomePage(title: 'Circular Progress Indicator Widget'),
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
      backgroundColor: Colors.yellowAccent,
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.yellowAccent,

      ),
      body:   Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:  <Widget>[
            Transform.scale(
              scale: 4,
              child: const CircularProgressIndicator(
                strokeWidth: 10,
                backgroundColor: Colors.pink,
                valueColor: AlwaysStoppedAnimation(Colors.blue),
              ),
            ),
            Transform.scale(
              scale: 2,
              child: const CircularProgressIndicator(
                backgroundColor: Colors.purple,
              ),
            ),
            const CircularProgressIndicator(
              backgroundColor: Colors.red,
              valueColor: AlwaysStoppedAnimation(Colors.green),
            ),
          ],
        ),
      )
    );
  }
}
