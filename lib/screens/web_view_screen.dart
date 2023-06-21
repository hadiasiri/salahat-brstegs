import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

// import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../providers/webview_prov.dart';

// stelss
// stful
// ignore: use_key_in_widget_constructors
class WebViewScreen extends StatefulWidget {
  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  BannerAd? _bannerAd;
  bool _isLoading = true;
  bool _isBack = false;
  bool _isLoadBanner = false;
  InterstitialAd? _interstitialAd;

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      _bannerAd = BannerAd(
          size: AdSize.banner,
          adUnitId: '',
          listener: BannerAdListener(onAdFailedToLoad: (ad, error) {
            print('banner failed=>$error');
          }, onAdLoaded: (ad) {
            setState(() {
              _isLoadBanner = true;
            });
          }),
          request: const AdRequest());
      _bannerAd?.load();
      final ctrl = WebViewController()
        ..loadRequest(
          Uri.parse('https://saleh.tech-view.site/1index.php'),
        )
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageFinished: (finish) async {
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
              try {
                if (((await Provider.of<WebviewProv>(context, listen: false)
                        .webViewController
                        ?.canGoBack()) ??
                    false)) {
                  setState(() {
                    _isBack = true;
                  });
                } else {
                  setState(() {
                    _isBack = false;
                  });
                }
                setState(() {
                  _isLoading = false;
                });
              } catch (_) {}
            },
          ),
        )
        ..setJavaScriptMode(JavaScriptMode.unrestricted);

      Provider.of<WebviewProv>(context, listen: false).setWebViewCtrl(ctrl);
    });
    super.initState();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<WebviewProv, WebViewController?>(
        selector: (_, prov) => prov.webViewController,
        builder: (_, ctrl, ___) {
          return Scaffold(
            key: _key,
            endDrawer: Drawer(
              child: ListView(
                children: [
                  DrawerHeader(
                    decoration: const BoxDecoration(color: Color(0xFFFCFCFC)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset('images/logo.png', height: 100),
                        const Text(
                          '   استراحة برستيجس ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )
                      ],
                    ),
                  ),
                  const Divider(color: Colors.grey),
                  ListTile(
                    trailing: const Icon(
                      Icons.home,
                      color: Color(0xFF177da5),
                    ),
                    title: const Text(
                      'الصفحة الرئيسية',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      textAlign: TextAlign.right,
                    ),
                    onTap: () {
                      if (ctrl != null) {
                        ctrl.loadRequest(Uri.parse(
                            'https://saleh.tech-view.site/1index.php'));
                      }
                      Navigator.pop(context);
                    },
                  ),
                  const Divider(color: Colors.grey),
                  ListTile(
                    trailing: const Icon(
                      Icons.account_circle,
                      color: Color(0xFF177da5),
                    ),
                    title: const Text(
                      'حسابي ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      textAlign: TextAlign.right,
                    ),
                    onTap: () {
                      if (ctrl != null) {
                        ctrl.loadRequest(Uri.parse(
                            'https://work-hadi.me/saleh-test/ac.php'));
                      }
                      Navigator.pop(context);
                    },
                  ),
                  const Divider(color: Colors.grey),
                  ListTile(
                      trailing: const Icon(
                        Icons.info,
                        color: Color(0xFF177da5),
                      ),
                      title: const Text(
                        ' عن التطبيق ',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      onTap: () {
                        ctrl?.loadRequest(
                          Uri.parse(
                              'https://work-hadi.me/saleh-test/s/abute.php'),
                        );
                        Navigator.pop(context);
                      }),
                  const Divider(color: Colors.grey),
                  ListTile(
                      trailing: const Icon(
                        Icons.privacy_tip_sharp,
                        color: Color(0xFF177da5),
                      ),
                      title: const Text(
                        ' سياسة الخصوصية',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      onTap: () {
                        ctrl?.loadRequest(
                          Uri.parse(
                              'https://work-hadi.me/saleh-test/s/Privacy-Policy.php'),
                        );
                        Navigator.pop(context);
                      }),
                  const Divider(color: Colors.grey),
                  ListTile(
                    trailing: const Icon(
                      Icons.share,
                      color: Color(0xFF177da5),
                    ),
                    title: const Text(
                      'مشاركة التطبيق',
                      textAlign: TextAlign.right,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    onTap: () {
                      Share.share(
                          'قم بتحميل تطبيق استراحة برستيجس https://onelink.to/926j9h',
                          subject: ' قم بتحميل تطبيق استراحة برستيجس ');
                      Navigator.pop(context);
                    },
                  ),
                  const Divider(color: Colors.grey),
                  ListTile(
                      trailing: const Icon(
                        Icons.chat,
                        color: Color(0xFF177da5),
                      ),
                      title: const Text(
                        'تواصل معنا',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      onTap: () {
                        ctrl?.loadRequest(
                          Uri.parse(
                              'https://profile.hadiasiri.com/public/connect-us'),
                        );
                        Navigator.pop(context);
                      }),
                  const Divider(color: Colors.grey),
                  _isLoadBanner == true
                      ? SizedBox(
                          height: 0,
                          width: 0,
                          child: AdWidget(ad: _bannerAd!),
                        )
                      : SizedBox(
                          height: 0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                '',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              CircularProgressIndicator(),
                            ],
                          )),
                ],
              ),
            ),
            appBar: AppBar(
              actionsIconTheme: const IconThemeData(
                  color: Color.fromARGB(255, 13, 12, 12), size: 40),
              actions: [
                IconButton(
                    onPressed: () {
                      _key.currentState?.openEndDrawer();
                    },
                    icon: const Icon(Icons.menu))
              ],
              centerTitle: true,
              toolbarHeight: 69,
              backgroundColor: Color(0xFFeceff1),
              elevation: 0,
              title: Image.asset(
                'images/logo.png',
                width: 75,
              ),
            ),
            body: _isLoading || ctrl == null
                ? Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(
                        color: Color(0xFF177da5),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        '.. جاري التحميل ',
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ))
                : WebViewWidget(
                    controller: ctrl,
                  ),
          );
        });
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
