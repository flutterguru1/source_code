import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      /*
      appBar: AppBar(
        title: Text(widget.title),
      ),
      */
      body: Stack(
        children: [
          //content //the form
          Positioned(
              child:Align(
                alignment: FractionalOffset.center,
                child: Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).orientation == Orientation.portrait?MediaQuery.of(context).size.height*0.25:MediaQuery.of(context).size.height*0.14) ,
                  padding: EdgeInsets.only(right: MediaQuery.of(context).orientation == Orientation.portrait ? 0 : MediaQuery.of(context).size.width*0.05),
                  height: MediaQuery.of(context).orientation == Orientation.portrait?MediaQuery.of(context).size.height*0.55: MediaQuery.of(context).size.height*0.85,
                 // color: Colors.blue,
                  child:SingleChildScrollView( //for nice rendering and keyboard
                    physics: const NeverScrollableScrollPhysics(),
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min, //must
                      //  crossAxisAlignment: CrossAxisAlignment.stretch,
                      children:  [
                        //login title
                        const Flexible(
                          child: Positioned(child: Align(
                            alignment: FractionalOffset.center,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 25),
                              child: Text("Login",
                                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),),
                            ),
                          ),
                          ),
                        ),
                        //input key and login btn container
                        Flexible(
                          flex: 2,
                          child: Container( //to occupy the whole available space
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(right:MediaQuery.of(context).size.width*0.05 ),
                            child:Stack(
                              clipBehavior: Clip.none,
                              children: [
                                // username and password container
                                LayoutBuilder(builder: (context, constraints){
                                  return Container(
                                    width: constraints.maxWidth*0.8,
                                    // height: MediaQuery.of(context).orientation == Orientation.portrait? constraints.maxHeight : constraints.maxHeight*0.5,
                                    margin: MediaQuery.of(context).orientation == Orientation.portrait ? const EdgeInsets.symmetric(vertical: 40): const EdgeInsets.symmetric(vertical: 0),
                                    padding:  EdgeInsets.only(left: MediaQuery.of(context).orientation == Orientation.portrait ?20 :50),
                                    decoration:BoxDecoration(
                                      borderRadius: const BorderRadius.only(topRight: Radius.circular(100), bottomRight: Radius.circular(100)),
                                      color: const Color(0XFFe5cec6),
                                      shape: BoxShape.rectangle,
                                      boxShadow: [
                                        BoxShadow(
                                          offset: -const Offset(4, 4),
                                          color: const Color(0XFFFFFFFF),
                                          blurRadius: 4.0,
                                          spreadRadius: 4.0,
                                        ),
                                        const BoxShadow(
                                          offset: Offset(4, 4),
                                          //color: Color(0xFF170b35),
                                          color: Colors.black87,
                                          blurRadius: 4.0,
                                          spreadRadius: 4.0,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      //user name field
                                      children:  [
                                        const TextField(
                                          decoration: InputDecoration(
                                            icon: Icon(Icons.person),
                                            border: InputBorder.none,
                                            labelText: 'Username',
                                            labelStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: const BoxDecoration(
                                              border:  Border( bottom: BorderSide(width: 2, color: Colors.black26))
                                          ),
                                        ),
                                        const TextField(
                                          decoration: InputDecoration(
                                            icon: Icon(Icons.lock),
                                            border: InputBorder.none,
                                            labelText: 'Password',
                                            labelStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),

                                //login btn
                                Positioned(
                                  right: MediaQuery.of(context).orientation == Orientation.portrait? MediaQuery.of(context).size.width*0.1: MediaQuery.of(context).size.width*0.15 ,
                                  top: 0,
                                  bottom: 0,
                                  width: MediaQuery.of(context).orientation == Orientation.portrait? MediaQuery.of(context).size.width*0.2: MediaQuery.of(context).size.width*0.1,
                                  child:  Container(
                                    alignment: Alignment.center,
                                    child: InkWell(
                                      child: const Icon(Icons.arrow_forward, size: 40, color: Colors.white,
                                      ),
                                      onTap: (){
                                        showToast(context, "Login btn clicked");
                                        FocusScope.of(context).requestFocus(FocusNode());//hide keyboard ie dedicating focus to another node
                                      },
                                    ),
                                    decoration:   BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.redAccent,
                                      gradient: const LinearGradient(
                                          colors: [Color(0XFF16cbc9), Color(0XFF24e9a2)]
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          offset: -const Offset(2, 2),
                                          color: const Color(0XFFFFFFFF),
                                          blurRadius: 4.0,
                                          spreadRadius: 4.0,
                                        ),
                                        const BoxShadow(
                                          offset: Offset(4, 4),
                                          //color: Color(0xFF170b35),
                                          color: Colors.black87,
                                          blurRadius: 4.0,
                                          spreadRadius: 4.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        //forgot password
                        Flexible(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                            child:InkWell(
                              child:  const Text("Forgot?",
                                textAlign: TextAlign.right,
                                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              onTap: (){
                                showToast(context, "Forgot password");
                              },
                            ),
                          ),
                        ),

                        //register btn
                        Flexible(
                          child: Container(
                            width: 150,
                            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                            margin: const EdgeInsets.only(bottom: 20),
                            child: GestureDetector(
                              child: const Text("Register",
                                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.redAccent),
                              ),
                              onTap: (){
                                showToast(context, "ready to register");
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
          //top inner border
          ClipPath(
            clipper: BorderCurveClipper(),
            child:  Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*.5,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.blueGrey,
                      Colors.red,
                    ],
                  )
              ),
            ),
          ),
          //top curve
          ClipPath(
            clipper: CurveClipper(),
            child:  Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*.4,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0XFFf8911f),
                    Color(0XFFf8635b),
                  ],
                )
              ),
            ),
          ),



          //border bottom dec cont
          Positioned(
            child:Align(
                alignment: FractionalOffset.bottomCenter,
                child: ClipPath(
                  clipper: BorderBottomDecClipper(),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.25,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [
                            Color(0XFFdaf2fd),
                            Color(0XFFd7f1fa),
                          ],
                        )
                    ),
                  ),
                )
            ),
          ),
   //bottom decor
   Positioned(
       child:Align(
         alignment: FractionalOffset.bottomCenter,
         child: ClipPath(
           clipper: BottomDecClipper(),
           child: Container(
             width: MediaQuery.of(context).size.width,
             height: MediaQuery.of(context).size.height*0.25,
             decoration: const BoxDecoration(
                 gradient: LinearGradient(
                   begin: Alignment.bottomLeft,
                   end: Alignment.topRight,
                   colors: [
                     Color(0XFF04eefe),
                     Color(0XFF4da9fa),
                   ],
                 )
             ),
           ),
         )
       ),
   ),
        ],
      ),

    );
  }
  //define a toast method
  void showToast(BuildContext context, String text){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text, textAlign: TextAlign.center, style: const TextStyle(color: Colors.deepOrange, fontSize: 14),),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
    ));}
}

class BorderBottomDecClipper  extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height);
    path.cubicTo(
        size.width*.20, size.height*0.20,
        size.width*.75, size.height*.75,
        size.width, 0);
    path.lineTo(size.width, size.height);
    return path;
  }
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
class BottomDecClipper  extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
  Path path = Path();
  path.moveTo(0, size.height);
  path.cubicTo(
      size.width*.25, size.height*0.25,
      size.width*.85, size.height*.85,
      size.width, 0);
  path.lineTo(size.width, size.height);
  return path;
  }
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
 return false;
  }
}

class BorderCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.cubicTo(
      size.width * .75,
      size.height * .65,
      size.width * .15,
      size.height * .15,
      0,
      size.height,
    );
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class CurveClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
   Path path = Path();
   path.moveTo(0, 0);
   path.lineTo(size.width, 0);
   path.cubicTo(
     size.width * .8,
     size.height * .6,
     size.width * .20,
     size.height * .20,
     0,
     size.height,
   );
   path.close();

   return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
