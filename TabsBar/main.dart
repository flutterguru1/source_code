import 'dart:ui';

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
        primarySwatch: Colors.brown,
      ),
      home: const MyHomePage(title: 'Glass Morphism'),
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
    return DefaultTabController(
                      length: 3,
                      child: Scaffold(
                        backgroundColor: Colors.transparent,
                        appBar: AppBar(
                          backgroundColor: Colors.transparent,
                          bottom: const TabBar(
                            tabs: [
                              Tab(icon: Icon(Icons.music_note_outlined), text: "Songs",),
                              Tab(icon: Icon(Icons.playlist_play), text: "Playlists",),
                              Tab(icon: Icon(Icons.folder_outlined), text: "Folders",),
                            ],
                          ),
                          title: const Text('JJPlayer'),
                        ),
                        body: const TabBarView(
                          children: [
                            Center(child: Text("All songs in your device here...",
                                style: TextStyle(color: Colors.white30, fontSize: 25),),),
                            Center( child:Text("Your Favorite list of  songs here...",
                              style: TextStyle(color: Colors.white30, fontSize: 25),),),
                            Center(child: Text("Songs in their bags goes here...",
                              style: TextStyle(color: Colors.white30, fontSize: 25),),),
                          ],
                        ),
                      ),
                    );
  }
}
