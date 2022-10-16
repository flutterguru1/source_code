import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

//# local database: we need hide and hive flutter. add libraries in pubspec.yaml file 
 // hive: ^2.2.1
//  hive_flutter: ^1.1.0

void main() async{
  //initialize hive db
  await Hive.initFlutter();
  //open the shopping box
  await Hive.openBox("shopping_box");
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping List Cart App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'Shopping Cart App | @SimpleFlutter'),
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

  //define a variable to shopping box reference
  final _shoppingBox = "shopping_box";

  //form key for validating the form fields
  final _formKey = GlobalKey<FormState>();
  // Create a text controller and use it to retrieve the current value of the TextField.
  final _itemNameController = TextEditingController();
  final _countController = TextEditingController();

//dispose as necessarily
  @override
  void dispose() {
     Hive.close(); //closes all open boxes
    _itemNameController.dispose();
    _countController.dispose(); //dispose controllers
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(color: Colors.white70),),
        backgroundColor:  const Color(0XFF1f0f47),
      ),
      body:Container(//screen decoration
        //alignment: Alignment.center,
        width: double.infinity,
        padding: const EdgeInsets.only(bottom: 44),
        decoration: const BoxDecoration(
          gradient:LinearGradient(
            begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0XFF1f0f47), Color(0XFF1e7d81),]
          )
        ),
        //use a listenable builder, it will make sure it builds whenever needed
        child: ValueListenableBuilder(
          valueListenable: Hive.box(_shoppingBox).listenable(),
          builder: (BuildContext context, Box box, _){ //use keys to get item names
            if(box.keys.isEmpty){
              return  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  cartHeadWidget("0"),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    child: const Text(
                      "Empty Cart!!😀 Click + \n Below to add items...🚀",
                      style: TextStyle(color: Colors.white70, fontSize: 30, fontWeight: FontWeight.bold,
                      ),),
                  ),
                ],
              );
            }
            //list to hold items to show in listview
            List _itemNames =[];
            //add header item at index 0,
            _itemNames.add("card head");
            //add items   and reverse items names to newest first
            _itemNames.addAll(box.keys.toList().reversed.toList());
            //list view builder
            return ListView.builder(
                itemCount: _itemNames.length,
                itemBuilder: (context, index){
                  if(index ==0){
                    return cartHeadWidget((_itemNames.length-1).toString()); //remove the head item
                  }
                  return shoppingRowItem(_itemNames.elementAt(index).toString(), Hive.box(_shoppingBox).get(_itemNames.elementAt(index)).toString());
                });
          },
        ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          //launch add shopping item dialog
          addNewShoppingItem(context);
        },
        tooltip: 'add Item',
        child:Container(
          //padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0XFFe5cec6),
            shape: BoxShape.circle,
            gradient: const RadialGradient(
                colors: [Color(0XFF1e4e68), Color(0XFF1e7d81),]
            ),
            boxShadow: [
              BoxShadow(
                offset: -const Offset(2, 2),
                color: const Color(0XFFFFFFFF),
                blurRadius: 3.0,
                spreadRadius: 3.0,
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
          child: const Icon(Icons.add, size:60, color: Colors.white70,),
        ),

      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  //cart head widget
  Widget cartHeadWidget(String itemCount){
    return FractionallySizedBox(
      widthFactor: 0.21,
      child: Container(
        // padding: const EdgeInsets.only(left: 0),
        margin: const EdgeInsets.only(top:25, bottom: 15),
        decoration:BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
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
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            const Icon(Icons.shopping_cart, size: 70,),
            RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: Transform.translate(
                      offset: const Offset(-40.0, -12.0),
                      child:  Text(
                        itemCount,
                        style: const TextStyle(fontSize: 22, color: Colors.deepOrange, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //single shopping item
  Widget shoppingRowItem(String name, String count){
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      height: 110,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration:BoxDecoration(
        borderRadius: BorderRadius.circular(15), //50 or 20
        color: Colors.white70,
        border: Border.all(width: 1, color: Colors.black54),
        boxShadow: [
          BoxShadow(
            offset: -const Offset(1, 1),
            color: const Color(0XFFFFFFFF),
            blurRadius: 1.0,
            spreadRadius: 1.0,
          ),
          const BoxShadow(
            offset: Offset(1, 1),
            color: Color(0xFF170b35),
            blurRadius: 1.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //leading icon the cart item
          Flexible(
            child:Container(
              alignment: Alignment.center,
              height: 40,
              width: 40,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: const Icon(
                Icons.add_shopping_cart,
                size: 20,
              ),
              decoration:BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
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
            ),
          ),

          //the item title and count
          Flexible(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                Text(
                  name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.black54, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text("Count: "+count, style: const TextStyle(color: Colors.black38, fontSize: 15, fontWeight: FontWeight.bold),),
              ],
            ),
          ),

          //end btns
          Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //Edit btn
                  InkWell(
                    onTap:(){ //edit btn clicked
                      editShoppingItem(context, name, count);
                    },
                    child:  Container(
                      alignment: Alignment.center,
                      height: 40,
                      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: const Icon(
                        Icons.edit,
                        size: 20,
                      ),
                      decoration:BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                        color: const Color(0XFFe5cec6),
                        shape: BoxShape.rectangle,
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
                            blurRadius: 2.0,
                            spreadRadius: 2.0,
                          ),
                        ],
                      ),
                    ),
                  ),

                  //delete btn
                  InkWell(
                    onTap: (){ //delete btn clicked
                      deleteShoppingItem(context, name);
                    },
                    child:   Container(
                      alignment: Alignment.center,
                      height: 40,
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal:8),
                      margin: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
                      child: const Icon(
                        Icons.delete,
                        size: 20,
                      ),
                      decoration:BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                        color: const Color(0XFFe5cec6),
                        shape: BoxShape.rectangle,
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
                            blurRadius: 2.0,
                            spreadRadius: 2.0,
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
              )
          ),
        ],
      ),
    );
  }

  //edit shopping item
  void editShoppingItem(BuildContext context, String item, String count){
    showDialog(
        context: context,
        builder: (BuildContext context){
          //set initial values before it
          _itemNameController.text = item;
          _countController.text = count;
          return AlertDialog(
            title: const Text("Edit & Save Item"),
            content: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min, //the dialog takes only size it needs
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 4),
                      child: TextFormField(
                        controller: _itemNameController, //will help get the field value on submit
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Item Name',
                        ),
                        //validator on submit, must return null when every thing ok
                        // The validator receives the text that the user has entered.
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return 'Empties not allowed';}
                          else if(value.trim().isEmpty){
                            return "Empties not allowed";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 4),
                      child: TextFormField(
                        controller: _countController, //will help get the field value on submit
                        // initialValue: "1",
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Count',
                        ),
                        //validator on submit, must return null when every thing ok
                        // The validator receives the text that the user has entered.
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return 'Empties not allowed';}
                          else if(value.trim().isEmpty){
                            return "Empties not allowed";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                )
            ),
              //actions
            actions: [
              //dismiss dialog
              TextButton(onPressed: (){
                Navigator.of(context).pop(); // dismiss dialog
              }, child: const Text("Cancel")),

              //save btn
              TextButton(
                child: const Text("Save"),
                  onPressed: (){
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      //name used as a key and count is used as a value.
                      //delete the prev and add new
                      Hive.box(_shoppingBox).delete(item);
                      //use put to add a key-value map
                      Hive.box(_shoppingBox).put(_itemNameController.text,_countController.text); //key is the item name.
                      _itemNameController.clear(); //clear text in field
                      _countController.clear(); //clear the field
                      Navigator.of(context).pop(); // dismiss dialog
                    }

                  },

              ),

            ],
          );
        });
  }

  //delete a shopping item from the shopping box
  void deleteShoppingItem(BuildContext context, String item){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: const Text("Are You Sure ??"),
            content: Text("Confirm to remove \"$item\" from the shopping list"),
            actions: [
              TextButton(onPressed: (){
                Navigator.of(context).pop(); // dismiss dialog
              }, child: const Text("Cancel")),

              TextButton(
                child: const Text("Remove"),
                  onPressed: (){
                    Hive.box(_shoppingBox).delete(item); //key is item name.
                    Navigator.of(context).pop(); // dismiss dialog
                  },

              ),

            ],
          );
        });
  }

 //add new shopping item to the box dialog
  void addNewShoppingItem(BuildContext context){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: const Text("Add New Shopping Item"),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min, //the dialog takes only size it needs
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 4),
                    child: TextFormField(
                      controller: _itemNameController, //will help get the field value on submit
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Item Name',
                      ),
                      //validator on submit, must return null when every thing ok
                      // The validator receives the text that the user has entered.
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Empties not allowed';}
                        else if(value.trim().isEmpty){
                          return "Empties not allowed";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 4),
                    child: TextFormField(
                      controller: _countController, //will help get the field value on submit
                     // initialValue: "1",
                       keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Count',
                      ),
                      //validator on submit, must return null when every thing ok
                      // The validator receives the text that the user has entered.
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Empties not allowed';}
                        else if(value.trim().isEmpty){
                          return "Empties not allowed";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              )
            ),
            actions: [
              TextButton(
                 child: const Text("Cancel"),
                  onPressed: (){
            //    showToast(context, "Canceled");  //toast a cancelled sms
                Navigator.of(context).pop(); // dismiss dialog
              },
              ),

              TextButton(
                child: const Text("Add"),
                  onPressed: (){
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      //name used as a key and count is used as a value.
                      //use put to add a key-value map
                      Hive.box(_shoppingBox).put(_itemNameController.text,_countController.text); //key is the item name.
                    //show saved values
                   //   showToast(context, "Saved! Item: "+_itemNameController.text +", Count: "+_countController.text);
                      _itemNameController.clear(); //clear text in field
                      _countController.clear(); //clear the field
                      Navigator.of(context).pop(); // dismiss dialog
                    }
                  },

              ),

            ],
          );
        });
  }

  //define a toast method
  void showToast(BuildContext context, String text){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text, textAlign: TextAlign.center, style: const TextStyle(color: Colors.deepOrange, fontSize: 14),),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
    ));}
}
