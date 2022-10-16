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
  late final RewardedAd rewardedAd;
  final String rewardedAdUnitId = "ca-app-pub-3940256099942544/5224354917"; //sample ad unit id

  //load ad
  @override
  void initState(){
    super.initState();

    //load ad here...
    _loadRewardedAd();
  }

  //method to load an ad
  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: rewardedAdUnitId,
      request:const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        //when failed to load
        onAdFailedToLoad: (LoadAdError error){
          print("Failed to load rewarded ad, Error: $error");
        },
        //when loaded
        onAdLoaded: (RewardedAd ad){
          print("$ad loaded");
          // Keep a reference to the ad so you can show it later.
          rewardedAd = ad;

          //set on full screen content call back
          _setFullScreenContentCallback();
        },
      ),
    );
  }

  //method to set show content call back
  void _setFullScreenContentCallback(){
       if(rewardedAd == null) return;
    rewardedAd.fullScreenContentCallback = FullScreenContentCallback(
      //when ad  shows fullscreen
      onAdShowedFullScreenContent: (RewardedAd ad) => print("$ad onAdShowedFullScreenContent"),
      //when ad dismissed by user
      onAdDismissedFullScreenContent: (RewardedAd ad){
        print("$ad onAdDismissedFullScreenContent");

      //dispose the dismissed ad
        ad.dispose();
      },
       //when ad fails to show
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error){
        print("$ad  onAdFailedToShowFullScreenContent: $error ");
        //dispose the failed ad
        ad.dispose();
      },

      //when impression is detected
      onAdImpression: (RewardedAd ad) =>print("$ad Impression occured"),
    );

  }

  //show ad method
  void _showRewardedAd(){
    //this method take a on user earned reward call back
    rewardedAd.show(
      //user earned a reward
      onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem){
        //reward user for watching your ad
        num amount = rewardItem.amount;
        print("You earned: $amount");
      }
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: InkWell(
          onTap: _showRewardedAd,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            height: 100,
            color: Colors.orange,
            child: const Text(
              "Show Rewarded Ad",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 35),
            ),
          ),

        ),
      ),
    );
  }



}
