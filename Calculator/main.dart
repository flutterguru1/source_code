import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:math_expressions/math_expressions.dart';

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
      home: const MyHomePage(title: 'Simple Calculator With Flutter'),
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
  //bg color
  Color bgColor = const Color(0XFFcad2df);
  Color shadowColor1 = const Color(0XFF8c949f);
  Color shadowColor2 = const Color(0XFFe8ebfc);

  var answer = '0.0';
  double expFontSize = 50;

  List<String> buttons = [
    "AC", "C", "%", "/",
    "7", "8", "9", "x",
    "4", "5", "6", "-",
    "1", "2", "3", "+",
    "0", ".", "AC", "="
  ];
  late TextEditingController inputController;

  //initialize the input controller
  @override
  void initState() {
    inputController = TextEditingController()
      ..addListener(() {
        doCalculation();
      });
    super.initState();
  }

  //dispose
  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Container(
        padding:EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
        margin: EdgeInsets.all( MediaQuery.of(context).viewPadding.top),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            //output box
            Flexible(
              flex: 2,
              child:  Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top:MediaQuery.of(context).viewPadding.top, right:MediaQuery.of(context).viewPadding.top, left: MediaQuery.of(context).viewPadding.top,),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: bgColor,
                  boxShadow: [
                    //top inner shadow
                    BoxShadow(
                      offset: const Offset(5, 5),
                      blurRadius: 5,
                      color: shadowColor1,
                      inset: true,
                    ),
                    BoxShadow(
                      offset: const Offset(-5, -5),
                      blurRadius: 5,
                      color: shadowColor2,
                      inset: true,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container( //first container expression and answer
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                    //  margin: const EdgeInsets.only(bottom: 0),
                      child:  TextField( //input expression
                        textAlign: TextAlign.right,
                        controller: inputController,
                        keyboardType: TextInputType.none,
                        style:  TextStyle(
                          fontSize:expFontSize,
                          decoration: TextDecoration.none,
                        ),
                        decoration: const InputDecoration(
                            enabledBorder: InputBorder.none,
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: "0.0",
                            hintTextDirection: TextDirection.rtl
                        ),
                      ),
                    ),
                    Container(
                      //the answer container
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      margin: const EdgeInsets.only(bottom: 5),
                      child:  Text(answer,
                        style: const TextStyle(fontSize: 25, color: Colors.black45),),
                    ),
                  ],
                ),
              ),
            ),

            //keyboard
            Flexible(
              flex: 7,
              child: Container(
                padding: const EdgeInsets.only(top: 15,),
                child:  GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                  itemBuilder: (context, index){
                    return inputButton(buttons.elementAt(index));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void doCalculation() {
    var  expression = inputController.text;
    expression = expression.replaceAll("x", "*");
    Parser p = Parser();
    Expression mathExpression = p.parse(expression);
    ContextModel cm = ContextModel();
    double eval = mathExpression.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();
  }

  Widget inputButton(String text){
    return InkWell(
      onTap: (){
        setState(() { //change the input text field
          if(inputController.text.length>=10){expFontSize=40;}else{expFontSize=50;}
          if(text =="AC"){inputController.text = ""; answer ="0.0";} //clear all
          else if(text =="C"){
            inputController.text =inputController.text.substring(0, inputController.text.length - 1);
            if(inputController.text.isEmpty){answer ="0.0";}
          }
          else if(text =="="){}
          else {inputController.text = inputController.text +text;}
        });
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        padding: const EdgeInsets.all(5),
        child: Text(text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 38, color: Colors.black38,),
        ),
        decoration:BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)), //50 or 20
          color: bgColor,
          shape: BoxShape.rectangle,
          boxShadow: [
            //top btn shadow
            BoxShadow(
              offset: -const Offset(5, 5),
              blurRadius: 5,
              color: shadowColor2,
            ),
             BoxShadow(
              offset: const Offset(5, 5),
              color: shadowColor1,
              blurRadius: 5.0,
            ),
          ],
        ),
      ),
    );
  }
}
