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
      title: 'Flutter Juice App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Juice App'),
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
  //categories
  List<String> categories = ["Popular", "Recommended", "Special Order", "Fresh Juice", "Trending", "Customize" ];
  int currentCategoryIndex = 0;
  bool searching = false;
  final _searchController = TextEditingController();
  FocusNode focusNode = FocusNode();

  final List<Product> _products = [];
  List<Product> filteredProducts = [];
  var detail = "Introducing the all-new Platform for retailers, entrepreneurs and ecommerce professionals. Tune in for expert insights, strategies and tactics to help grow your business. ";

  @override
  void initState() {
    //add products
    _products.add(Product("Apple Juice", detail, "\$3.9", "assets/products/apple.png", 898, bgColor: const Color(0xfff57888), nameColor: const Color(0xff9a0c1e)));
    _products.add(Product("Green Apple Juice", detail, "\$2.8", "assets/products/greenapple.png", 158, bgColor: const Color(0XFFdeefa3), nameColor: const Color(0XFF86a51d) ));
    _products.add(Product("Mango Juice", detail, "\$1.5", "assets/products/mango.png", 1500));
    _products.add(Product("Orange Juice", detail, "\$1.9", "assets/products/orange.png", 20000, bgColor: const Color(0Xfffecb7e), nameColor: const Color(0XFFfd9902)));
    _products.add(Product("Papaya Juice", detail, "\$3.5", "assets/products/papaya.png", 459, bgColor: const Color(0XFFfecdaf), nameColor: const Color(0xffae4302)));
    _products.add(Product("Strawberry", detail, "\$4.2", "assets/products/strawberry.png", 120, bgColor: const Color(0XFFfca9ad), nameColor: const Color(0Xffc40610)));
    _products.add(Product("Watermelon", detail, "\$5.0", "assets/products/watermelon.png", 898));

    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        backgroundColor: Colors.orange,
        title: Center(child:Text(widget.title)),
        elevation: 0,
        actions: const [
          Padding(padding: EdgeInsets.only(right: 50),
          child: Icon(Icons.print),)
        ],
      ),
      body:body(),
    );
  }
//body
 Widget body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _searchFieldContainer(),
        _buildCategories(),
        _buildPageTitle(),
        _buildProducts(),
      ],
    );
 }

 Widget _buildPageTitle(){

    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xfff0f0f0)))
      ),
      child: Text(categories[currentCategoryIndex]+" Juice",
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
    );
 }

 Widget  _searchFieldContainer(){
    return SizedBox(
      height: 52,
      child:Container(
        margin: const EdgeInsets.only(top: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
        width: MediaQuery.of(context).size.width*.8,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
            color: Color(0xfff4f4f4), //f0f0f0
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:  [
           Flexible(
             flex: 2,
             child:  TextField(
            controller: _searchController,
               focusNode: focusNode,
             onChanged: (value){
              if(!searching){searching = true;}
                //do the search here
               filter(value);
               setState(() { }); //ensure dirty tree is rebuilt
             },
             style: const TextStyle(),
             decoration: const InputDecoration(
                 border: InputBorder.none,
                 hintText: 'Search...',
                 hintStyle: TextStyle(
                   color: Colors.black26,
                 )),

           ),
         ),
            Flexible(
              child: IconButton(
                onPressed: (){
                  if(searching){
                    FocusScope.of(context).requestFocus(FocusNode());//hide keyboard ie dedicating focus to another node
                    _searchController.text= "";
                    filteredProducts.clear(); //ensure search results is clean
                  }else{
                    //request focus to the search field
                    FocusScope.of(context).requestFocus(focusNode);
                  }
                  searching = !searching;
                  setState(() { }); //rebuild dirty tree
                },
                icon:  Icon(searching ? Icons.close : Icons.search, color: Colors.black26,),
              ),
            ),
          ],
        ),
      )

    );
 }

 //filtering/search logic
 void filter(String query){
    if(_products.isNotEmpty){
      filteredProducts.clear(); //clear the result list
      for(Product product in _products){
        if(product.name.toLowerCase().contains(query.toLowerCase())){
          filteredProducts.add(product);
        }
      }
    }

 }

 Widget _buildCategories() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20) ,
      child:
      SizedBox(
      height: 30,
      child: ListView.builder(
          itemCount: categories.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index){
          return  currentCategoryIndex == index ? _buildCurrentCategory(index): _buildCategory(index);
          }
      ),
    )
    );
 }
  Widget _buildCurrentCategory(int index){
    return  Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: Text(
          categories.elementAt(index),
          style: const TextStyle(fontSize: 12, color: Colors.white),
        ),
        decoration:  BoxDecoration(
          color: Colors.black,
          border: Border.all(),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
    );
  }
  Widget _buildCategory(index) {
    return  InkWell(
      onTap: (){
        setState(() {
          currentCategoryIndex = index;
        });
      },
      child:
      Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        categories.elementAt(index),
        style: const TextStyle(fontSize: 12,),
      ),
      decoration:  BoxDecoration(
        border: Border.all(),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
    ),
    );
  }
  Widget _buildProducts() {
    return Expanded(
      child: ListWheelScrollView(
      itemExtent: 200,
      children:productsList(searching && _searchController.text.isNotEmpty ? filteredProducts : _products),
    ),
    );
  }

 List<Widget> productsList(List<Product> products) {
    List<Widget> list = [];
    for(int i=0; i <products.length; i++ ){
      //some even current category
      Product product = products.elementAt(i);
      if(currentCategoryIndex%2 !=0){
        if(i/2 ==0){
          continue;
        }
      }
      list.add(
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            margin: const EdgeInsets.symmetric(horizontal: 4,),
            child: Stack(
              children: [
                //the product detail
                Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: product.bgColor,
                      borderRadius: const BorderRadius.all(Radius.circular(10),),
                  ),
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(top: 55),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width*.65,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //title
                          Text(
                            product.name,
                            style: TextStyle(
                                color: product.nameColor, fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          //detail
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 15),
                            child: Text(
                                product.details,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          //price, likes btn
                         Expanded(
                           child:  Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               //price
                              Flexible(
                                  flex:2,
                                  child: Text(product.price,
                                    style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                                  ),
                              ),
                               Flexible(
                                 flex: 4,
                                 child: Row(
                                 children: [
                                   //like btn
                                   IconButton(
                                     icon:  product.liked ? const Icon(Icons.favorite, color: Colors.pink,) :const Icon(Icons.favorite_border_outlined, color: Colors.pink,),
                                     onPressed: (){
                                       if(product.liked){
                                         product.likes = product.likes-1;
                                       }else{
                                         product.likes = product.likes +1;
                                       }
                                       setState(() { }); //rebuild
                                     },
                                   ),
                                   //likes
                                   Text(
                                     product.likes.toString(),
                                     style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                                   ),
                                 ],
                               ),
                             ),

                             ],
                           ),
                         )

                        ],
                      ),
                    ),

                ),

                //the image
                Align(
                  alignment: FractionalOffset.centerRight,
                  child: Image.asset(
                    product.imgUrl,
                  ),
                ),
              ],
            ),
          ),
      );
    }
    return list;
  }
}

//product model class
class Product{
  //members
  String name, details, price, imgUrl;
  int likes;
  Color bgColor, nameColor;
  bool liked;
  //constructor
  Product(this.name, this.details, this.price, this.imgUrl, this.likes, {this.bgColor =const Color(0XFFf8efac), this.nameColor=const Color(0Xffb8954d), this.liked = false});
}
