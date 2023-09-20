import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed('/search'); // Replace '/home' with the route to your home screen
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/wiki_logo.png', width: MediaQuery.of(context).size.width * 0.5,),
            const Text('Wiki Search', style: TextStyle(color: Colors.black, fontSize: 24.0),)
          ],
        ),
      ),
    ) ;
  }
}