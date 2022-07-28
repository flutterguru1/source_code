import 'package:flutter/material.dart';

import 'detail.dart';
import 'model.dart';

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
  //start working here
  //members
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
    _products.add(Product("Mango Juice", detail, "\$1.5", "assets/products/mango.png", 1500, bgColor: const Color(0xfffde197), nameColor: const Color(0xffeeae04)));
    _products.add(Product("Papaya Juice", detail, "\$3.5", "assets/products/papaya.png", 459, bgColor: const Color(0XFFfecdaf), nameColor: const Color(0xffae4302)));
    _products.add(Product("Strawberry", detail, "\$4.2", "assets/products/strawberry.png", 120, bgColor: const Color(0XFFfca9ad), nameColor: const Color(0Xffc40610)));
    _products.add(Product("Orange Juice", detail, "\$1.9", "assets/products/orange.png", 20000, bgColor: const Color(0Xfffecb7e), nameColor: const Color(0XFFe38902)));
    _products.add(Product("Watermelon", detail, "\$5.0", "assets/products/watermelon.png", 898, bgColor: const Color(0XFFfca9ad), nameColor: const Color(0Xffc40610)));

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
            child: Icon(Icons.print),
          )
        ],
      ),
      body: _buildBody(),
    );
  }

 Widget _buildBody() {
    return Column(
      children: [
        _searchFieldContainer(),
        _buildCategories(),
        _buildPageTitle(),
        _buildProductsListview(searching && _searchController.text.isNotEmpty ? filteredProducts : _products),
      ],
    );
  }

 Widget _searchFieldContainer() {
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
                  icon:  Icon(searching ? Icons.close : Icons.search, color: Colors.black26,),
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
                 ),
              ),
            ],
          ),
        ),
    );
  }

  //filter
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

 Widget _buildCurrentCategory(int index) {
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

 Widget _buildCategory(int index) {
    return InkWell(
      onTap: (){
        setState(() {
          currentCategoryIndex = index;
        });
      },
      child: Container(
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

 Widget _buildPageTitle() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Color(0xfff0f0f0)))
      ),
      child: Text(categories[currentCategoryIndex]+" Juice",
        style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ),
    );
  }

 Widget _buildProductsListview(List<Product> products) {
   return Expanded( //important
     child: ListView.builder(
         itemCount: products.length ,
         itemBuilder: (context, index){
           Product product = products.elementAt(index);
           return _buildProductItem(index, product);
         }
     ),
   );
  }

  Widget _buildProductItem(int index, Product product) {
    //some even current category
    if(currentCategoryIndex%2 !=0){
      if(index/2 ==0){
        return Container();
      }
    }

  //clickable item
    return InkWell(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context){
          return DetailPage(product);
           }),
        );
      },
      child: Container(
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

                    Row(
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
                                    product.liked = false;
                                  }else{
                                    product.likes = product.likes +1;
                                    product.liked = true;
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
                  ],
                ),
              ),

            ),

            //the image
            Align(
                alignment: FractionalOffset.centerRight,
                child: Hero(
                  tag: product.name,
                  child: Image.asset(
                    product.imgUrl,
                    width: 150,
                    fit: BoxFit.fitHeight,
                  ),
                )
            ),


          ],
        ),
      ),
    );
  }
}
