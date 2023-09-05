import 'dart:async';

import 'package:dinder/view/home_page_view.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                LoginScreen()
            )
        )
    );
    // Future.delayed(Duration(seconds: 5),(){
    //   print(">>>>>>>>>>>>>>>>>>>>");
    //   Navigator.of(context,MaterialPageRoute(builder: (context) => const LoginScreen()));
    // });
    return Scaffold(
      body: Center(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                child:
                new CircleAvatar(
                  backgroundImage: new AssetImage('assets/images/logo.png'),
                  radius: 120.0,
                  child: new Container(
                    padding: const EdgeInsets.all(0.0),
                    // child: new Text('Sight'),
                  ),
                )
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 25, 16, 0),
              child: Text("Dinder", style: TextStyle(color: Colors.black,fontSize: 44,fontStyle: FontStyle.italic,fontWeight: FontWeight.w600,),),
            ),
          ],
          // decoration: BoxDecoration(
          //   image: const DecorationImage(
          //     image: AssetImage("assets/images/dlogo1.png"),
          //     fit: BoxFit.fitHeight,scale: 1005,
          //   ),
          // ),
          // child: Padding(
          //   padding: const EdgeInsets.fromLTRB(16, 50, 16, 0),
          //   child: Text("Dinder", style: TextStyle(color: Colors.black,fontSize: 24),),
          // ),
        ),
      ),
    );
  }
}
