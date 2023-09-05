import 'dart:convert';
import 'dart:developer';

import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_detector/flutter_swipe_detector.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swipe_cards/swipe_cards.dart';

class MainScreen extends StatefulWidget {
  String email;
  MainScreen(this.email, {super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // List<dynamic> dogs = [];
  bool _clicked = false;
  int _red_heart = 0;
  int black_heart = 0;
  int blue_heart = 0;
  int count = 0;
  int? saveRedHeart;
  int? saveBlueHeart;
  int? saveBlackHeart;
  var _dog = "";

  static const int _swipeHistoryLimit = 4;
  final List<SwipeDirection> _swipeHistory = [];
  // MatchEngine? _matchEngine;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final AppinioSwiperController controller = AppinioSwiperController();

  void _handelClick() {
    fetchDog();
    setState(() {
      _clicked = !_clicked;
    });
    print(_dog);
  }

  void initState(){
    // super.initState();
    fetchDog();
    getHeart();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   onPressed: fetchDog,
        // ),
        body: SingleChildScrollView(
          // height: MediaQuery.of(context).size.height,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[Color(0xff000000), Color(0xff49aea6)]
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
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 16),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Icon(CupertinoIcons.heart_solid,color: Colors.red, size: 36,),
                        // _red_heart == null ? Text('0', style: TextStyle(color: Colors.black87,fontSize: 16,fontWeight: FontWeight.w600)):
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
                  color: Colors.white,
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
                height: 50,
              ),
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.65,
                child: AppinioSwiper(
                  backgroundCardsCount:0,
                  swipeOptions: const AppinioSwipeOptions.only(left: true,right: true,bottom: true),
                  unlimitedUnswipe: true,
                  controller: controller,
                  // unswipe: _unswipe,
                  onSwiping: (AppinioSwiperDirection direction) {
                    if(direction.toString() == "AppinioSwiperDirection.bottom"){
                      black_heart += 1;
                      fetchDog();
                      setState(() {
                        black_heart += 1;
                      });
                        print(black_heart);
                        print("black_heart");
                    }if(direction.toString() == "AppinioSwiperDirection.right"){
                      setState(() {
                        fetchDog();
                        _red_heart +=1;
                      });
                      print(_red_heart);
                      print("_red_heart");
                    }if(direction.toString() == "AppinioSwiperDirection.left"){
                      setState(() {
                        blue_heart += 1;
                        fetchDog();
                      });
                      print(blue_heart);
                      print("blue_heart");
                    }
                    // // if(direction.toString() == "AppinioSwiperDirection.bottom"){
                    // //   print(black_heart);
                    // //   print("black_heart");
                    //   fetchDog();
                    //
                    //   if(direction.toString() == "AppinioSwiperDirection.bottom"){
                    //     count+=1;
                    //     print(count.toString() + " __________");
                    //   }
                    // //   black_heart += 1;
                    // //   print(black_heart.toString() + "  bbbbbbbb");
                    // // }
                    debugPrint(direction.toString() + "   nnnnnnnnnnn");
                  },
                  onSwipe: _swipe,
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    bottom: 50,
                  ),
                  // onEnd: _onEnd,
                  cardsCount: 100,
                  cardsBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
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
                    );
                  },
                ),
              ),
              Container(
                child: Text("ghghgsdhghdsghgs"),
              )
              // SizedBox(
              //   height: 450,
              //   child: SwipeDetector(
              //     child: Container(
              //       margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              //       height: 400,
              //       decoration: BoxDecoration(
              //         border: Border.all(
              //             color: Colors.black26,
              //             width: 2.0,
              //             style: BorderStyle.solid
              //         ), //Border.all
              //         borderRadius: BorderRadius.only(
              //           topLeft: Radius.circular(10.0),
              //           topRight: Radius.circular(10.0),
              //           bottomLeft: Radius.circular(10.0),
              //           bottomRight: Radius.circular(10.0),
              //         ),
              //         boxShadow: [
              //           BoxShadow(
              //             color: Colors.black12,
              //             offset: const Offset(
              //               1.0, 1.0,
              //             ),
              //             blurRadius: 10.0,
              //             spreadRadius: 2.0,
              //           ), //BoxShadow
              //           BoxShadow(
              //             color: Colors.white,
              //             offset: const Offset(0.0, 0.0),
              //             blurRadius: 0.0,
              //             spreadRadius: 0.0,
              //           ), //BoxShadow
              //         ],
              //         image: DecorationImage(
              //           image: NetworkImage(_dog),
              //           fit: BoxFit.cover
              //         )
              //       ),
              //     ),
              //     onSwipeDown: (offset){
              //       _addSwipe(SwipeDirection.down);
              //       fetchDog();
              //       setState(() {
              //         black_heart= black_heart + 1;
              //       });
              //       saveData(black_heart);
              //       // black_heart += 1;
              //       // print(black_heart);
              //       // print("2131tttttttttttt656735436");
              //     },
              //     onSwipeRight: (offset){
              //       _addSwipe(SwipeDirection.right);
              //       fetchDog();
              //       setState(() {
              //         blue_heart= blue_heart + 1;
              //       });
              //       saveData(blue_heart);
              //       // blue_heart += 1;
              //       // print(blue_heart);
              //       // print("2131tttttttttttt656735436");
              //     },
              //     onSwipeLeft: (offset){
              //       _addSwipe(SwipeDirection.left);
              //       fetchDog();
              //       setState(() {
              //         _red_heart= _red_heart + 1;
              //       });
              //       saveData(_red_heart);
              //     },
              //   ),
              // ),
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
  }

  // void _addSwipe(
  //     SwipeDirection direction,
  //     ) {
  //   setState(() {
  //     _swipeHistory.insert(0, direction);
  //     if (_swipeHistory.length > _swipeHistoryLimit) {
  //       _swipeHistory.removeLast();
  //     }
  //   });
  // }
  Future<void> saveData(value) async{
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('saveRed', _red_heart);
    pref.setInt('saveBlue', blue_heart);
    pref.setInt('saveBlack', black_heart);
  }

  void getHeart() async{
    final SharedPreferences pref =await SharedPreferences.getInstance();
    saveRedHeart= pref.getInt('saveRed');
    saveBlueHeart= pref.getInt('saveBlue');
    saveBlackHeart= pref.getInt('saveBlack');
    if(saveRedHeart!=null){
      _red_heart = saveRedHeart!;
    }
    if(saveBlueHeart!=null){
      blue_heart = saveBlueHeart!;
    }
    if(saveBlackHeart!=null){
      black_heart = saveBlackHeart!;
    }
    print(saveRedHeart);
    print('saveRedHeart');
    setState(() {

    });
  }

  void _swipe(int index, AppinioSwiperDirection direction) {
    log("the card was swiped to the: " + direction.name);
    // Future.delayed()
    // fetchDog();
  }

  void _unswipe(bool unswiped) {
    if (unswiped) {
      log("SUCCESS: card was unswiped");
    } else {
      log("FAIL: no card left to unswipe");
    }
  }

  void _onEnd() {
    log("end reached!");
  }
}