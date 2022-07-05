import 'package:flutter/material.dart';

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
        primarySwatch: Colors.pink,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Listview Builders- Flutter'),
        ),
        body:ListView.separated(
            itemCount: 40,
            separatorBuilder: (BuildContext context, int index) => const Divider( height: 1, thickness: 2,),
            itemBuilder: (context, index){
              //header
               if(index ==0){
                 return   Container(
                   height: 50,
                   color: Colors.pink[800],
                   child: const Center(child: Text('Listview made with ListView.Separated()',
                     style: TextStyle(fontWeight:FontWeight.bold, fontSize: 18, color: Colors.white70),)),
                 );
               }
               //item
              return   Container(
                 height: 50,
                 color: index%2 == 0 ? Colors.pink[500]: Colors.pink[600],
                 child:  Center(child: Text('Item ${index+1}', style: const TextStyle(color: Colors.white, fontSize: 16),)),
               );
            }
        ),
      ),
    );
  }
}

