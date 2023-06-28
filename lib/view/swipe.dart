import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'dart:developer';

import 'content.dart';
import 'example_buttons.dart';
import 'example_candidate_model.dart';
import 'example_card.dart';

class Swipe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swipe Cards Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SwipePage(title: 'Swipe Cards Demo'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SwipePage extends StatefulWidget {
  SwipePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _SwipePageState createState() => _SwipePageState();
}

class _SwipePageState extends State<SwipePage> {
  List<SwipeItem> _swipeItems = <SwipeItem>[];
  MatchEngine? _matchEngine;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final AppinioSwiperController controller = AppinioSwiperController();
  List<String> _names = [
    "Red",
    "Blue",
    "Green",
    "Yellow",
    "Orange",
    "Grey",
    "Purple",
    "Pink"
  ];
  List<Color> _colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.grey,
    Colors.purple,
    Colors.pink
  ];

  @override
  void initState() {
    for (int i = 0; i < _names.length; i++) {
      _swipeItems.add(SwipeItem(
          content: Content(text: _names[i], color: _colors[i]),
          likeAction: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Liked ${_names[i]}"),
              duration: Duration(milliseconds: 500),
            ));
          },
          nopeAction: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Nope ${_names[i]}"),
              duration: Duration(milliseconds: 500),
            ));
          },
          superlikeAction: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Superliked ${_names[i]}"),
              duration: Duration(milliseconds: 500),
            ));
          },
          onSlideUpdate: (SlideRegion? region) async {
            print("Region $region");
          }));
    }

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  CupertinoPageScaffold(
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.75,
            child: AppinioSwiper(
              backgroundCardsCount:3,
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
                bottom: 40,
              ),
              onEnd: _onEnd,
              cardsCount: candidates.length,
              cardsBuilder: (BuildContext context, int index) {
                return ExampleCard(candidate: candidates[index]);
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 80,
              ),
              swipeLeftButton(controller),
              const SizedBox(
                width: 20,
              ),
              swipeRightButton(controller),
              const SizedBox(
                width: 20,
              ),
              unswipeButton(controller),
            ],
          )
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