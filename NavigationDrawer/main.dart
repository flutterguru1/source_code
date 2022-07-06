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
        primarySwatch: Colors.deepOrange,
      ),
      home: const MyHomePage(title: 'Navigation Drawer with submenu - Flutter'),
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
  List<Menu> data = [];

  @override
  void initState() {
    for (var element in dataList) {
      data.add(Menu.fromJson(element));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: _buildDrawer(),
      ),
      body: const Center(child: Text("Main Screen Contents...", style: TextStyle(fontSize: 30),),)
    );
  }

  Widget _buildDrawer(){
    return ListView.separated(
      padding: const EdgeInsets.only(top: 0),
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        if(index ==0){
          return _buildDrawerHeader(data[index]);
        }
        return  _buildMenuList(data[index]);
      },
      separatorBuilder: (BuildContext context, int index) => const Divider( height: 1, thickness: 2,),
    );
  }

  Widget _buildDrawerHeader(Menu headItem){
    return DrawerHeader(
      margin: const EdgeInsets.only(bottom: 0),
      decoration: const BoxDecoration(
        color: Colors.deepOrange,
      ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(headItem.icon, color: Colors.white, size: 60,),
          const Spacer(),
          Text(headItem.title, style: const TextStyle(color: Colors.white, fontSize: 20),),
        ],
        ));
  }
  Widget _buildMenuList(Menu menuItem) {
    //build the expansion tile
    double lp = 0; //left padding
    double fontSize = 20;
    if(menuItem.level == 1){lp =20; fontSize =16;}
    if(menuItem.level == 2){lp =30; fontSize =14;}

    if (menuItem.children.isEmpty) {
      return Builder(
          builder: (context) {

            return
              InkWell(
                child:Padding(
                  padding: EdgeInsets.only(left: lp),
                  child: ListTile(
                    leading: Icon(menuItem.icon),
                    title: Text(
                      menuItem.title,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ),
                onTap: (){
                  // Close the drawer
                  Navigator.pop(context);

                  //Then direct user to dashboard page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Dashboard(menuItem),
                    ),
                  );


                },
              );
          }
      );
    }


    return  Padding(
      padding: EdgeInsets.only(left: lp),
      child: ExpansionTile(
        leading: Icon(menuItem.icon),
        title: Text(
          menuItem.title,
          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
        ),
        children: menuItem.children.map(_buildMenuList).toList(),
      ),
    );

  }
}


//The Menu Model
class Menu {
  int level =0;
  IconData icon = Icons.drive_file_rename_outline;
  String title ="";
  List<Menu> children = [];
  //default constructor
  Menu(this.level, this.icon, this.title, this.children);

  //one method for  Json data
  Menu.fromJson(Map<String, dynamic> json) {
    //level
    if(json["level"] != null){level = json["level"];}
    //icon
    if(json["icon"] != null){icon = json["icon"];}
    //title
    title = json['title'];
    //children
    if (json['children'] != null) {
      children.clear();
      //for each entry from json children add to the Node children
      json['children'].forEach((v) {
        children.add(Menu.fromJson(v));
      });
    }
  }
}


//menu data list
List dataList = [
  //menu data item
  {
    "level": 0,
    "icon": Icons.account_circle_rounded,
    "title": "@SimpleFlutter: The Best Flutter Channel On YT",
  },

  //menu data item
  {
    "level": 0,
    "icon": Icons.verified_outlined,
    "title": "Account",
    "children": [
      {
        "level":1,
        "icon": Icons.account_box,
        "title": "Username",
        "children":[
          {"title": "Change username",},
          {"title": "Reset Username"},
          {"title": "History Of change"},
        ],
      },
      {
        "level":1,
        "icon": Icons.lock,
        "title": "Password",
        "children":[
          {"title": "Change Password",},
          {"title": "Reset Password"},
          {"title": "History Of change"},
        ],
      },

      { "level":1,
        "icon": Icons.delete_forever,
        "title": "Delete Account"
      }
    ]
  },

  //menu data item
  {
    "level": 0,
    "icon": Icons.payments,
    "title": "Payments",
    "children": [
      {
        "level":1,
        "icon": Icons.paypal,
        "title": "Paypal",
      },
      {
        "level":1,
        "icon": Icons.credit_card,
        "title": "Credit Card",
      },

      { "level":1,
        "icon": Icons.credit_card,
        "title": "Debit Card"
      }
    ]
  },

  //menu data item
  {
    "level": 0,
    "icon": Icons.travel_explore,
    "title": "Trips",
    "children": [
      {
        "level":1,
        "icon": Icons.calendar_month,
        "title": "January",
        "children":[
          { "icon":Icons.calendar_view_day,
            "title": "15th, 9:30 AM",
          },
          { "icon":Icons.calendar_view_day,
            "title": "30th, 9:30 AM",
          },
        ],
      },
      {
        "level":1,
        "icon": Icons.calendar_month,
        "title": "June",
        "children":[
          { "icon":Icons.calendar_view_day,
            "title": "16th, 10:45 AM",
          },
          { "icon":Icons.calendar_view_day,
            "title": "29th, 10:45 AM",
          },
        ],
      },
      {
        "level":1,
        "icon": Icons.calendar_month,
        "title": "November",
        "children":[
          { "icon":Icons.calendar_view_day,
            "title": "20th, 10:50 AM",
          },
        ],
      },
    ]
  },

  //menu data item
  {
    "level": 0,
    "icon": Icons.explore,
    "title": "Seminars",
    "children": [
      {
        "level":1,
        "icon": Icons.money,
        "title": "Entrepreneurship",
      },
      {
        "level":1,
        "icon": Icons.build,
        "title": "Self Confidence",
      },

      { "level":1,
        "icon": Icons.self_improvement,
        "title": "Financial Management"
      },
    ]
  },

  //menu data item
  {
    "level": 0,
    "icon": Icons.favorite,
    "title": "Favorite",
    "children": [
      {
        "level":1,
        "icon": Icons.water,
        "title": "Swimming",
      },
      {
        "level":1,
        "icon": Icons.sports_football,
        "title": "Football",
      },

      { "level":1,
        "icon": Icons.movie,
        "title": "Movie"
      },
      { "level":1,
        "icon": Icons.audiotrack,
        "title": "Singing"
      },
      { "level":1,
        "icon": Icons.run_circle_outlined,
        "title": "Jogging"
      },
    ]
  },
];


class Dashboard extends StatelessWidget{
  const Dashboard(this.menuItem, {Key? key}) : super(key: key);
  // Declare a field that holds the User
  final Menu menuItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Dashboard"),
        ),
        body: Center(
          child:Padding(padding: const EdgeInsets.symmetric(horizontal: 5),
          child:  Text(
            "Are you ready for  ${menuItem.title} ?",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          ),

        )
    );
  }

}
