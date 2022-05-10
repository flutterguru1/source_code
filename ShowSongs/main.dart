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
//on audio query plugin
  final OnAudioQuery _audioQuery = OnAudioQuery();

  //initial state method to request storage permission
  @override
  void initState() {
    super.initState();
    requestStoragePermission();
  }
  
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
                            //Center(child: Text("All songs in your device here...",style: TextStyle(color: Colors.white30, fontSize: 25),),),
							 //songs tab content
                            songsListView(),
                            Center( child:Text("Your Favorite list of  songs here...",
                              style: TextStyle(color: Colors.white30, fontSize: 25),),),
                            Center(child: Text("Songs in their bags goes here...",
                              style: TextStyle(color: Colors.white30, fontSize: 25),),),
                          ],
                        ),
                      ),
                    );
  }
  
   //request permission
  void requestStoragePermission() async{
    //only if platform is not web
    if(!kIsWeb){
      //check if not permission status
      bool status = await _audioQuery.permissionsStatus();
      //request it if not given
      if(!status){
        await _audioQuery.permissionsRequest();
      }
      //make sure set state method is called
      setState(() {

      });
    }
  }
  
  Widget songsListView() {
    //use future builder to create a list view with songs
  return  FutureBuilder<List<SongModel>>(
      future: _audioQuery.querySongs(
        sortType: SongSortType.DATE_ADDED,
        orderType: OrderType.DESC_OR_GREATER,
        uriType: UriType.EXTERNAL,
        ignoreCase: true,
      ),
      builder: (context,item){
        //loading content indicator
        if(item.data == null){
          return const Center(child: CircularProgressIndicator(),);
        }else if(item.data!.isEmpty) {
          return const Center(child: Text("No Songs Found!!, Add Some", style: TextStyle(color: Colors.white30),),);
        }
        //songs are available build list view
        List<SongModel> songs = item.data!;
        return ListView.builder(
          itemCount:  songs.length,
          itemBuilder: (context, index){
         //   return Text(songs.elementAt(index).displayName, style: const TextStyle(color: Colors.white60),);

            return Container(
              margin: const EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0, right: 10, left: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(color: Colors.white70, width: 1.0, style: BorderStyle.solid),
              ),
            child:Text(songs.elementAt(index).displayName, style: const TextStyle(color: Colors.white60),),

            );
          },
        );

      },
    );
   // return const Center(child: Text("Text brother"),);
  }
}
