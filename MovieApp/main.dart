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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
 //current movie url
  String currentMovieUrl = "assets/images/movies/jurassic.webp";
  //list of movies
  List<Movie> movies =[];

  @override
  void initState() {
    //add movies to a movie list
    movies.add(Movie("Jurassic World", "assets/images/movies/jurassic.webp", "action", "1:35:48 hrs", "9.5"));
    movies.add(Movie("Thor", "assets/images/movies/thor.webp", "action", "2:6:18 hrs", "8.6"));
    movies.add(Movie("Doctor Strange", "assets/images/movies/doctor_strange.webp", "action", "1:15:07 hrs", "9.1"));
    movies.add(Movie("Sonic 2", "assets/images/movies/sonic2.webp", "action", "1:15:07 hrs", "9.1"));
    movies.add(Movie("Hawkeye", "assets/images/movies/hawkeye.webp", "action", "2:15:07 hrs", "8.8"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //cover
          Container(
              height: double.infinity,
              decoration:  BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(currentMovieUrl),
                      fit: BoxFit.cover
                  )
              ),

              child:BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: Colors.black.withOpacity(0.2),
                ),
              ),
          ),

          //movies list
          Positioned(
            child:Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                // color: Colors.blue,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*0.80,
                margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.05,),
                child: ListWheelScrollView(
                  itemExtent: 500,
                  onSelectedItemChanged: (index){
                    setState(() {
                     currentMovieUrl = movies[index].posterUrl;
                    });
                  },
                  children: _buildMovieCards(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //build the movie card
List<Widget> _buildMovieCards(){
    //cards holder
    List<Widget> cards = [];

    //create a card per each movie in movies
    for(Movie movie in movies){
      //add a card to cards
      cards.add(
        Container(
          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height*0.025,),
          width:MediaQuery.of(context).size.width*0.80,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(25.0),
              border: Border.all(color: Colors.black, width: 15.0, style: BorderStyle.solid),
              //color: Colors.brown,
              image:  DecorationImage(
                  image:AssetImage(movie.posterUrl),
                  fit: BoxFit.cover),
          ),
          child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.black.withOpacity(0.9),
                height: 80.0,
                width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Column(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(child: Text(movie.title, style: const TextStyle(color: Colors.white,fontSize: 18),)),
                      Center(child: Text(movie.genre, style: const TextStyle(color: Colors.white60),)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                         Row(
                          children: [
                            const Icon(Icons.star, color: Colors.yellow, size: 16,),
                            Text(" "+movie.stars, style: const TextStyle(color: Colors.white60, fontSize: 16),),

                          ],
                        ),
                          Row(
                            children: [
                              const Icon(Icons.access_time_filled, color: Colors.white, size: 16,),
                              Text(" "+movie.duration, style: const TextStyle(color: Colors.white60, fontSize: 16),),
                            ]
                          ),
                          Row(
                              children: const [
                                Icon(Icons.play_circle_fill, color: Colors.white, size: 16,),
                                Text(" watch", style: TextStyle(color: Colors.white60, fontWeight: FontWeight.bold, fontSize: 16),),
                              ]
                          ),
                      ],)
                    ],
                  ),

              )),
        ),
      );
    }

    //return the cards
  return cards;
}
}


class Movie{
  //members
  String title, posterUrl, genre, duration, stars;
  //constructor
  Movie( this.title, this.posterUrl, this.genre, this.duration, this.stars);
}
