import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nike_shoe_shop/product.dart';
import 'package:nike_shoe_shop/repository.dart';
import 'dart:math' as math;

import 'detail.dart';

//app entry
void main(){
  runApp(const NikeShoesShop());
}

class NikeShoesShop extends StatelessWidget{
  const NikeShoesShop({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Nike shoes App",
      home: NikeShoesHome(title: "Nike Shoes Shop"),
    );
  }
}

class NikeShoesHome extends StatefulWidget {
  const NikeShoesHome({ required this.title, Key? key}) : super(key: key);
  final String title;
  @override
  State<StatefulWidget> createState() {
    return _NikeShoesHomeState();
  }
}
class _NikeShoesHomeState  extends State<NikeShoesHome> {
  //members
  Repository repository = Repository();
  var bgColor = const Color(0xff1d1f21);

  var categories = ["Basketball", "Running", "Training",];
  int _activeCategoryIndex =0;

  List<String> productGroups =[];
  int _activeProductGroupIndex =0;
  late Product _activeProduct;

  final PageController _pageController = PageController(viewportFraction: 0.7);

  //navigation bg color method
  navColor(){
    if(Platform.isAndroid){
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          systemNavigationBarColor: bgColor,
          systemNavigationBarIconBrightness: Brightness.light,
          statusBarColor: bgColor,
        ),
      );
    }
  }
  @override
  void initState() {
    //groups
    productGroups = repository.productGroups();
    productGroups.addAll(repository.productGroups());
    //active product
    _activeProduct = repository.firstProductInGroup(
        productGroups.elementAt(_activeProductGroupIndex));
    //set navigation bg color
    navColor();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: Image.asset("assets/extra/logo.png", color: Colors.white60,),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child:  Icon(Icons.segment, color: Colors.white60,),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20),
            child:  Icon(Icons.work_outline, color: Colors.white60,),
          ),
        ],
      ),
      body: _body(),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  /*
  *  home body
  * */
  Widget _body(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCategories(),
        _buildProductListview(),
      ],
    );
  }

  /* ======================
  ======== products listview =======
   */
  Widget _buildProductListview(){
    return Center(
      child: SizedBox(
        height: 400, // card height
        child: PageView.builder(
          itemCount: productGroups.length,
          controller: _pageController,
          onPageChanged: (int index) {
            setState(() {
              _activeProductGroupIndex = index;
              _activeProduct = repository.firstProductInGroup(productGroups.elementAt(_activeProductGroupIndex));
            });
          },
          itemBuilder: (context, index) {
            return _activeProductGroupIndex == index ? _activeProductItem(): _productItem(index);
          },
        ),
      ),
    );
  }

  Widget _activeProductItem(){
    return InkWell(
      onTap: (){},
      child: Transform.scale(
        scale: 1,
        child: Stack(
          children: [
            LayoutBuilder(builder: (context, layoutConstraints) {
              return Container(
                alignment: Alignment.topLeft,
                width: layoutConstraints.maxWidth,
                margin: const EdgeInsets.only(right: 30),
                padding: const EdgeInsets.only(left: 30, top: 30),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(50),),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text("NIKE AIR", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,letterSpacing: -1),),
                    const Text("AIR JORDAN 1 MID SE GC", maxLines: 1, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22,letterSpacing: -2,),),
                    const Text("\$200", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25,letterSpacing: -2),),
                    const Padding(padding: EdgeInsets.only(top: 20),
                      child:  Text("NIKE AIR",
                        style: TextStyle(fontSize: 70, color: Colors.black12, letterSpacing: -6,),
                      ),),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: 100,
                        padding: const EdgeInsets.all(30),
                        alignment: Alignment.centerRight,
                        child: const Icon(Icons.add, size: 28,),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
                          color: _activeProduct.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 90),
                child: Transform.rotate(angle: -math.pi/6,
                  child: Hero(
                    tag: "tag",
                    child: Image.asset(
                      _activeProduct.url,
                      fit: BoxFit.cover,),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _productItem(int index){
    return Transform.scale(
      scale: 0.85,
      child: Stack(
        children: [
          LayoutBuilder(builder: (context, layoutConstraints) {
            return Container(
              alignment: Alignment.topLeft,
              width: layoutConstraints.maxWidth,
              margin: const EdgeInsets.only(right: 30),
              padding: const EdgeInsets.only(left: 30, top: 30),
              decoration: const BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.all(Radius.circular(50),),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text("NIKE AIR", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,letterSpacing: -1),),
                  const Text("AIR JORDAN 1 MID SE GC", maxLines: 1, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22,letterSpacing: -2),),
                  const Text("\$200", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25,letterSpacing: -2),),
                  const Padding(padding: EdgeInsets.only(top: 20),
                    child:  Text("NIKE AIR",
                      style: TextStyle(fontSize: 70, color: Colors.black12, letterSpacing: -6,),
                    ),),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 100,
                      padding: const EdgeInsets.all(30),
                      alignment: Alignment.centerRight,
                      child: const Icon(Icons.add, size: 28,),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
                        color: repository.firstProductInGroup(productGroups.elementAt(index)).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 70),
              child: Transform.rotate(angle: -math.pi/6,
                child: Image.asset(repository.firstProductInGroup(productGroups.elementAt(index)).url),
              ),
            ),
          ),

        ],
      ),
    );
  }
  /*
  ===============
  ===== end products listview =========
  * */

  /* ================================
  ======= categories ==============
   */
  Widget _buildCategories(){
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 40) ,
        child: SizedBox(
          height: 40,
          child: ListView.builder(
              itemCount: categories.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index){
                return  _activeCategoryIndex == index ? _activeCategory(index): _buildCategory(index);
              }
          ),
        )
    );
  }

  Widget _activeCategory(int index) {
    return  Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        categories.elementAt(index),
        style:  TextStyle(fontSize: 20, color: _activeProduct.primaryColor),
      ),

    );
  }

  Widget _buildCategory(int index) {
    return InkWell(
      onTap: (){
        setState(() {
          if (_pageController.hasClients) {
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
            );
          }
          _activeCategoryIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          categories.elementAt(index),
          style: const TextStyle(fontSize: 20, color: Colors.white60),
        ),
      ),
    );
  }

/* ================================
  ======= end categories ==============
   */

  /*
======= bottom nav =========
 */
  Widget _buildBottomNav(){
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      height: 90,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      decoration:  BoxDecoration(
        color: _activeProduct.primaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(30)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.home_outlined),
          Container(
            height: 60,
            width: 60,
            padding: const EdgeInsets.all(5),
            child: Icon(Icons.add_circle_outline, color: _activeProduct.primaryColor,),
            decoration: const BoxDecoration(
              color: Color(0xff1d1f21),
              shape: BoxShape.circle,
            ),
          ),
          const Icon(Icons.person),
        ],
      ),
    );
  }
}
