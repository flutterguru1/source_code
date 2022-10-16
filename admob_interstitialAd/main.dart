import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  //initialize ads sdk
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  //app
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
      home: const MyHomePage(title: 'Flutter Google Ads'),
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

  //members
  //ad
  late final InterstitialAd interstitialAd;
  final String interstitialAdUnitId = "ca-app-pub-3940256099942544/1033173712"; //sample ad unit id

  //load ads
  @override
  void initState(){
    super.initState();

    //load ad here...
    _loadInterstitialAd();
  }

  //method to load an ad
  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad){
          //keep a reference to the ad as you can show it later
          interstitialAd = ad;

          //set on full screen content call back
          _setFullScreenContentCallback(ad);
        },
        onAdFailedToLoad: (LoadAdError loadAdError){
          //ad failed to load
          print("Interstitial ad failed to load: $loadAdError");
        }
      ),

    );
  }

  //method to set show content call back
  void _setFullScreenContentCallback(InterstitialAd ad){

    ad.fullScreenContentCallback = FullScreenContentCallback(

      onAdShowedFullScreenContent: (InterstitialAd ad) => print("$ad onAdShowedFullScreenContent"),

      onAdDismissedFullScreenContent: (InterstitialAd ad){
        print("$ad onAdDismissedFullScreenContent");

      //dispose the dismissed ad
        ad.dispose();
      },

      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error){
        print("$ad  onAdFailedToShowFullScreenContent: $error ");
      },

      onAdImpression: (InterstitialAd ad) =>print("$ad Impression occured"),
    );

  }

  //show ad method
  void _showInterstitialAd(){
    interstitialAd.show();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: InkWell(
          onTap: _showInterstitialAd,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            height: 100,
            color: Colors.deepPurple,
            child: const Text(
              "Show Interstitial Ad",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 35),
            ),
          ),

        ),
      ),
    );
  }



}
