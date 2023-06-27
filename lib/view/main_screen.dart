import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swipe_to/swipe_to.dart';

class MainScreen extends StatefulWidget {
  String email;
  MainScreen(this.email, {super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<dynamic> dogs = [];
  bool _clicked = false;
  int _red_heart = 0;
  int black_heart = 0;
  int blue_heart = 0;
  var _dog = "";

  void _handelClick() {
    fetchDog();
    setState(() {
      _clicked = !_clicked;
    });
    print(_dog);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: fetchDog,
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 60.h,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[Color(0xff2d343c), Color(0xff49aea6)]
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.black54,
                        blurRadius: 15.0,
                        offset: Offset(0.0, 0.75)
                    )
                  ],
                ),
                child: Center(
                  child: Text(
                    "Welcome "+widget.email , style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20,vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Icon(CupertinoIcons.heart_solid,color: Colors.red, size: 36,),
                        Text(_red_heart.toString(), style: TextStyle(color: Colors.black87,fontSize: 16,fontWeight: FontWeight.w600),)
                      ],
                    ),
                    Column(
                      children: [
                        Icon(CupertinoIcons.heart_solid,color: Colors.black87, size: 36,),
                        Text(black_heart.toString(), style: TextStyle(color: Colors.black87,fontSize: 16,fontWeight: FontWeight.w600),)
                      ],
                    ),
                    Column(
                      children: [
                        Icon(CupertinoIcons.heart_solid,color: Colors.blueAccent, size: 36,),
                        Text(blue_heart.toString(), style: TextStyle(color: Colors.black87,fontSize: 16,fontWeight: FontWeight.w600),)
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 0.5,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xFF707070),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      offset: const Offset(
                        2.0,
                        2.0,
                      ),
                      blurRadius: 4.0,
                      spreadRadius: 0.5,
                    ), ///BoxShadow
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              SwipeTo(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  height: 400,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black26,
                        width: 2.0,
                        style: BorderStyle.solid
                    ), //Border.all
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: const Offset(
                          1.0, 1.0,
                        ),
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      ), //BoxShadow
                      BoxShadow(
                        color: Colors.white,
                        offset: const Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                      ), //BoxShadow
                    ],
                    image: DecorationImage(
                      image: NetworkImage(_dog),
                      fit: BoxFit.cover
                    )
                  ),
                ),
                onLeftSwipe: () {
                  fetchDog();
                  _red_heart += 1;
                  print(_red_heart);
                  print("65656565678787");
                  print('Callback from Swipe To Left');
                },
                onRightSwipe: () {
                  fetchDog();
                  blue_heart += 1;
                  print(blue_heart);
                  print('Callback from Swipe To Right');
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void fetchDog() async {
    print("11111111111111");
    var dogUrgl = 'https://dog.ceo/api/breeds/image/random';
    final uri = Uri.parse(dogUrgl);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var parsedResponse = jsonResponse as Map<String, dynamic>;
      setState(() {
        _dog = parsedResponse['message'];
        print(_dog);
      });
      print("2222222222222");
    }

    // print("objectuuiuiuiuiu");
    // const url = 'https://dog.ceo/api/breeds/image/random';
    // final uri = Uri.parse(url);
    // final response = await http.get(uri);
    // final body = response.body;
    // final json = jsonDecode(body);
    // setState(() {
    //   dogs = json['message'];
    // });
    // print("completeeeeeeeeeee");
  }
}