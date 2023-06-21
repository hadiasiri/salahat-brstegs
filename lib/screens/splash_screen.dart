import 'package:flutter/material.dart';
import 'package:flutter_hadi/screens/web_view_screen.dart';

import 'main_nav_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 4),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainNavScreen(),
        ),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFCFCFC),
        // appBar: AppBar(title: const Text(''),backgroundColor: Colors.black,),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              // Image(image: NetworkImage('')),
              Image(image: AssetImage('images/logo1.png')),
              Text(
                "",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                'Hadi Asiri © تطوير',
                style: TextStyle(fontSize: 15),
              ),
              // Image.asset(
              //   'images/logo.png',
              //   width: 200,
              //   height: 200,
              // ),
              // Image.network('src'),
            ],
          ),
        ));
  }
}
