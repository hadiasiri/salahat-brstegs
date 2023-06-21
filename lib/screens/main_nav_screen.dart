import 'package:flutter/material.dart';
import 'package:flutter_hadi/my_class/my_navgation.dart';
//import 'package:flutter_hadi/screens/athkar_screen.dart';
//import 'package:flutter_hadi/screens/profile_screen.dart';
import 'package:flutter_hadi/screens/web_view_screen.dart';
//import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_hadi/screens/web_view_screencopy.dart';
//import 'package:flutter_hadi/screens/web_view_screencopyy.dart';
// import 'package:flutter_hadi/screens/web_view_screencopyyy.dart';
// import 'package:flutter_hadi/screens/web_view_screencopyyyy.dart';
import 'package:flutter_hadi/providers/webview_prov.dart';
import 'package:provider/provider.dart';

class MainNavScreen extends StatefulWidget {
  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  @override
  void initState() {
    super.initState();

    // 1. This method only call when App in background and not terminated(not closed)

    // 2. This method only call when App in forground it mean app must be opened

    // 3. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method

    // if (message.data['_id'] != null) {
    //   Navigator.of(context).push(
    //     MaterialPageRoute(
    //       builder: (context) => DemoScreen(
    //         id: message.data['_id'],
    //       ),
    //     ),
    //   );
    // }
  }

  int _count = 1;
  List<NavBar> listNav = <NavBar>[
    // NavBar('Athkar', WebViewScreencopyyyy()),
    // NavBar('Athkar', WebViewScreencopyy()),
    // NavBar('Pay', WebViewScreencopyy()),
    NavBar('Profile', WebViewScreencopy()),
    NavBar('Web', WebViewScreen()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listNav[_count].widget,
      bottomNavigationBar: Consumer<WebviewProv>(builder: (_, prov, __) {
        return BottomNavigationBar(
          currentIndex: _count,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          unselectedFontSize: 12,
          selectedFontSize: 15,
          onTap: (value) {
            if (value == 0) {
              prov.resetCtrlCopy();
            } else if (value == 1) {
              prov.resetCtrl();
            }
            setState(() {
              _count = value;
            });
          },
          selectedItemColor: Color(0xFF177da5),
          unselectedItemColor: Color(0xFFAEA9A9),
          backgroundColor: Color(0xFFeceff1),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.email),
              label: 'تواصل معنا',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'الرئيسية',
            ),
          ],
        );
      }),
    );
  }
}
// flutter build apk --split-per-abi
