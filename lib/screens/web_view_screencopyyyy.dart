import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

// import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

// stelss
// stful
// ignore: use_key_in_widget_constructors
class WebViewScreencopyyyy extends StatefulWidget {
  @override
  State<WebViewScreencopyyyy> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreencopyyyy> {
  WebViewController? _webViewController;
  BannerAd? _bannerAd;
  bool _isLoading = true;
  bool _isBack = false;
  bool _isLoadBanner = false;

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    _webViewController = WebViewController()
      ..loadRequest(
        Uri.parse('https://takteksa.com/profile'),
      )
      ..setNavigationDelegate(
          NavigationDelegate(onNavigationRequest: (request) {
        if (request.url.startsWith('https://takteksa.com')) {
          return NavigationDecision.navigate;
        } else {
          _launchURL(request.url);
          return NavigationDecision.prevent;
        }
      }, onPageStarted: (url) {
        setState(() {
          _isLoading = false;
        });
      }))
      ..setJavaScriptMode(JavaScriptMode.unrestricted);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xFFE2AA0C),
        child: SafeArea(
            child: Padding(
                padding: EdgeInsets.zero,
                child: Scaffold(
                  // appBar: AppBar(
                  //   backgroundColor: Colors.white,
                  //   elevation: 0,
                  //padding: EdgeInsets.only(top: 10),
                  // ),
                  key: _key,
                  body: _isLoading
                      ? Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            CircularProgressIndicator(
                              color: Color(0xFFE2AA0C),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Text(
                              '',
                              style: TextStyle(fontSize: 0),
                            )
                          ],
                        ))
                      : WebViewWidget(
                          controller: _webViewController!,
                        ),
                ))));
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
