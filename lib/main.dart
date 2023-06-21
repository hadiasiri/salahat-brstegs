import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

import 'package:flutter_hadi/providers/webview_prov.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_hadi/screens/splash_screen.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  InterstitialAd? _interstitialAd;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  MobileAds.instance.initialize();
  InterstitialAd.load(
      adUnitId: '',
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('InterstitialAd failed: $error');
        },
      ));
  Timer.periodic(const Duration(seconds: 15), (timer) {
    _interstitialAd?.show();
  });
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<WebviewProv>(
          create: (_) => WebviewProv(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    ),
  );
}
