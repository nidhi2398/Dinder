import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'example_buttons.dart';
import 'dart:convert';

class Swipe extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swipe Cards Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: SwipePage(title: 'Swipe Cards Demo'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SwipePage extends StatefulWidget {
  String email;
  SwipePage(this.email,{Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _SwipePageState createState() => _SwipePageState();
}

class _SwipePageState extends State<SwipePage> {
  List<SwipeItem> _swipeItems = <SwipeItem>[];
  MatchEngine? _matchEngine;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final AppinioSwiperController controller = AppinioSwiperController();

  int _red_heart = 0;
  int black_heart = 0;
  int blue_heart = 0;
  int? saveRedHeart;
  int? saveBlueHeart;
  int? saveBlackHeart;
  var _dog = "";


  @override
  void initState() {
    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    super.initState();
    setState(() {
      fetchDog();
    });
    // fetchDog();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.65,
            child: AppinioSwiper(
              backgroundCardsCount:0,
              swipeOptions: const AppinioSwipeOptions.all(),
              unlimitedUnswipe: true,
              controller: controller,
              unswipe: _unswipe,
              onSwiping: (AppinioSwiperDirection direction) {
                debugPrint(direction.toString());
              },
              onSwipe: _swipe,
              padding: const EdgeInsets.only(
                left: 25,
                right: 25,
                top: 50,
                bottom: 20,
              ),
              onEnd: _onEnd,
              cardsCount: 100,
              cardsBuilder: (BuildContext context, int index) {
                return Container(
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
                );
              },
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     const SizedBox(
          //       width: 80,
          //     ),
          //     swipeLeftButton(controller),
          //     const SizedBox(
          //       width: 20,
          //     ),
          //     swipeRightButton(controller),
          //     const SizedBox(
          //       width: 20,
          //     ),
          //     // unswipeButton(controller),
          //   ],
          // )
        ],
      ),
    );

    //   Scaffold(
    //     key: _scaffoldKey,
    //     appBar: AppBar(
    //       title: Text(widget.title!),
    //     ),
    //     body: Container(
    //         child: Stack(children: [
    //           Container(
    //             height: MediaQuery.of(context).size.height - kToolbarHeight,
    //             child: SwipeCards(
    //               matchEngine: _matchEngine!,
    //               itemBuilder: (BuildContext context, int index) {
    //                 return Container(
    //                   alignment: Alignment.center,
    //                   color: _swipeItems[index].content.color,
    //                   child: Text(
    //                     _swipeItems[index].content.text,
    //                     style: TextStyle(fontSize: 100),
    //                   ),
    //                 );
    //               },
    //               onStackFinished: () {
    //                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //                   content: Text("Stack Finished"),
    //                   duration: Duration(milliseconds: 500),
    //                 ));
    //               },
    //               itemChanged: (SwipeItem item, int index) {
    //                 print("item: ${item.content.text}, index: $index");
    //               },
    //               leftSwipeAllowed: true,
    //               rightSwipeAllowed: true,
    //               upSwipeAllowed: true,
    //               fillSpace: true,
    //               likeTag: Container(
    //                 margin: const EdgeInsets.all(15.0),
    //                 padding: const EdgeInsets.all(3.0),
    //                 decoration: BoxDecoration(
    //                     border: Border.all(color: Colors.green)
    //                 ),
    //                 child: Text('Like'),
    //               ),
    //               nopeTag: Container(
    //                 margin: const EdgeInsets.all(15.0),
    //                 padding: const EdgeInsets.all(3.0),
    //                 decoration: BoxDecoration(
    //                     border: Border.all(color: Colors.red)
    //                 ),
    //                 child: Text('Nope'),
    //               ),
    //               superLikeTag: Container(
    //                 margin: const EdgeInsets.all(15.0),
    //                 padding: const EdgeInsets.all(3.0),
    //                 decoration: BoxDecoration(
    //                     border: Border.all(color: Colors.orange)
    //                 ),
    //                 child: Text('Super Like'),
    //               ),
    //             ),
    //           ),
    //           Align(
    //             alignment: Alignment.bottomCenter,
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //               children: [
    //                 ElevatedButton(
    //                     onPressed: () {
    //                       _matchEngine!.currentItem?.nope();
    //                     },
    //                     child: Text("Nope")),
    //                 ElevatedButton(
    //                     onPressed: () {
    //                       _matchEngine!.currentItem?.superLike();
    //                     },
    //                     child: Text("Superlike")),
    //                 ElevatedButton(
    //                     onPressed: () {
    //                       _matchEngine!.currentItem?.like();
    //                     },
    //                     child: Text("Like"))
    //               ],
    //             ),
    //           )
    //         ]))
    // );
  }

  void _swipe(int index, AppinioSwiperDirection direction) {
    log("the card was swiped to the: " + direction.name);
    // Future.delayed()
    fetchDog();
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
}