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
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Listview Builders- Flutter'),
        ),
        body:ListView.builder(
            itemCount: 40,
            itemBuilder: (context, index){

              //header
               if(index ==0)return header();

               //item
              return item(index);
            }
        ),
      ),
    );
  }


  //item
  Widget item(int index){
    return Container(
      height: 50,
      color: index%2 == 0 ? Colors.blue[500]: Colors.blue[600],
      child:  Center(child: Text('Item ${index+1}', style: const TextStyle(color: Colors.white, fontSize: 16),)),
    );
  }
  //header
Widget header(){
    return   Container(
      height: 50,
      color: Colors.blue[800],
      child: const Center(child: Text('Listview made with ListView.Builder()',
        style: TextStyle(fontWeight:FontWeight.bold, fontSize: 18),)),
    );
}
}

