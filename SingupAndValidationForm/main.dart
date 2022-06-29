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
      title: 'Learning Flutter',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const MyHomePage(title: 'Flutter Forms and Form Fields'),
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
// Create a global key that uniquely identifies the Form widget
// and allows validation of the form.
  final _formKey = GlobalKey<FormState>();
  // Create a text controller and use it to retrieve the current value of the TextField.
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackButtonPressedShowExitDialog(context),
      child:  Scaffold(
        appBar: AppBar(title: Text(widget.title), backgroundColor: Colors.brown,),
        body:  SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Text(
                      "Registration Form".toUpperCase(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                    ),
                  ),
                  //user name
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 4),
                    child: TextFormField(
                      controller: _usernameController, //will help get the field value on submit
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                        hintText: 'Choose a username',
                      ),
                      //validator on submit, must return null when every thing ok
                      // The validator receives the text that the user has entered.
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Please choose a username to use';}
                        else if(value.length <4){
                          return "Too short username. choose a username with 4 or more characters";
                        }
                        return null;
                      },
                    ),
                  ),
                  //email name
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 4),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                        hintText: 'Enter Email address',
                      ),
                      //validator on submit, must return null when every thing ok // The validator receives the text that the user has entered.
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Please enter your email address';}
                        else if(!value.contains("@") || !value.contains(".") ){
                          return "Please enter a valid email address";}

                        return null;
                      },
                    ),
                  ),
                  //password
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 4),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: true, //hide password
                      obscuringCharacter: "*",
                      decoration: const InputDecoration(
                        icon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                        hintText: 'Password',
                      ),
                      //validator on submit, must return null when every thing ok // The validator receives the text that the user has entered.
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Please enter your password';}
                        else if(value.length <8){
                          return "Length of password's characters must be 8 or greater";
                        }
                        return null;
                      },
                    ),
                  ),
                  //confirm password
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 4),
                    child: TextFormField(
                      obscureText: true, //hide password
                      obscuringCharacter: "*",
                      decoration: const InputDecoration(
                        icon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                        hintText: 'Confirm Password',
                      ),
                      //validator on submit, must return null when every thing ok // The validator receives the text that the user has entered.
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Please re-enter  password';}
                        else if(value.length <8){
                          return "Length of password's characters must be 8 or greater";
                        }else if(value != _passwordController.text){
                          return " password mismatch";
                        }
                        return null;
                      },
                    ),
                  ),

                  //submit button
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 20)),
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {

                        //  toast(context, "username: "+usernameController.text +"email: "+emailController.text);
                          toast(context, "Thanks for Joining our family") ;
                          //direct user to dashboard page
                         Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Dashboard(User(_usernameController.text, _emailController.text, _passwordController.text)),
                            ),
                          );
                        }
                      },
                      child: SizedBox(width: double.infinity, child:  Text('Register Now'.toUpperCase(), textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30, ),),),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )


        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
  //define a toast method
  void toast(BuildContext context, String text){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text, textAlign: TextAlign.center,),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
    ));
  }

//close app confirm dialog
  Future<bool> _onBackButtonPressedShowExitDialog(BuildContext context)  async{
    bool? exitApp = await showDialog(
        context: context,
        builder: (BuildContext context){
          //create and return a dialog
          return AlertDialog(
            title: const Text("Really??"),
            content:  const Text("Do you want to close the app ?"),
            actions: <Widget> [
              //a no btn
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop(false);
                },
                child: const Text("No, Stay"),
              ),
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop(true);
                },
                child: const Text("Yes, Close"),
              ),
            ],
          );
        }
    );
    return exitApp ?? false;
  }

}

class Dashboard extends StatelessWidget{
  const Dashboard(this.user, {Key? key}) : super(key: key);
  // Declare a field that holds the User
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16.0),
              child: Text(user.username+ ", ", style: const TextStyle(fontSize: 40, color: Colors.green),),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text("Welcome", style: TextStyle(fontSize: 40,),),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text( "  To ",  style: TextStyle(fontSize: 40,)),),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text( "  Simple Flutter ",  style: TextStyle(fontSize: 40,)),),
          ],
        ),
      )
    );
  }

}

//the user
class User{
  final String username, email, password;
  const User(this.username, this.email, this.password);
}
