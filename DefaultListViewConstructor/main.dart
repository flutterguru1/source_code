import 'package:flutter/material.dart';
import 'package:learn_flutter/content/listview_builders.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Listview Builders- Flutter'),
        ),
        body:ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            Container(
              height: 50,
              color: Colors.amber[800],
              child: const Center(child: Text('Listview with default ListView() constructor',
              style: TextStyle(fontWeight:FontWeight.bold, fontSize: 18),)),
            ),
            Container(
              height: 50,
              color: Colors.amber[600],
              child: const Center(child: Text('Item 1')),
            ),
            Container(
              height: 50,
              color: Colors.amber[400],
              child: const Center(child: Text('Item 2')),
            ),
            Container(
              height: 50,
              color: Colors.amber[500],
              child: const Center(child: Text('Item 3')),
            ),
            Container(
              height: 50,
              color: Colors.amber[600],
              child: const Center(child: Text('Item 4')),
            ),
            Container(
              height: 50,
              color: Colors.amber[400],
              child: const Center(child: Text('Item 5')),
            ),
            Container(
              height: 50,
              color: Colors.amber[500],
              child: const Center(child: Text('Item 6')),
            ),
            Container(
              height: 50,
              color: Colors.amber[600],
              child: const Center(child: Text('Item 7')),
            ),
            Container(
              height: 50,
              color: Colors.amber[400],
              child: const Center(child: Text('Item 8')),
            ),
            Container(
              height: 50,
              color: Colors.amber[500],
              child: const Center(child: Text('Item 9')),
            ),
            Container(
              height: 50,
              color: Colors.amber[600],
              child: const Center(child: Text('Item 10')),
            ),
            Container(
              height: 50,
              color: Colors.amber[400],
              child: const Center(child: Text('Item 11')),
            ),
            Container(
              height: 50,
              color: Colors.amber[500],
              child: const Center(child: Text('Item 12')),
            ),
            Container(
              height: 50,
              color: Colors.amber[600],
              child: const Center(child: Text('Item 13')),
            ),
            Container(
              height: 50,
              color: Colors.amber[400],
              child: const Center(child: Text('Item 14')),
            ),
            Container(
              height: 50,
              color: Colors.amber[500],
              child: const Center(child: Text('Item 15')),
            ),
            Container(
              height: 50,
              color: Colors.amber[600],
              child: const Center(child: Text('Item 16')),
            ),
            Container(
              height: 50,
              color: Colors.amber[400],
              child: const Center(child: Text('Item 17')),
            ),
            Container(
              height: 50,
              color: Colors.amber[500],
              child: const Center(child: Text('Item 18')),
            ),
          ],
        )
      ),
    );
  }
 
}

