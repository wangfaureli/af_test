import 'package:flutter/material.dart';
import 'dart:math'; // it will allows us to get the pi constant


class FlipCard extends StatefulWidget {
  const FlipCard({Key? key}) : super(key: key);

  @override
  _FlipCardState createState() => _FlipCardState();
}

class _FlipCardState extends State<FlipCard> {
  //declare the isBack bool
  bool isBack = true;
  double angle = 0;

  void _flip() {
    setState(() {
      angle = (angle + pi) % (2 * pi);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF292a3e),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Now we will start making our Card
              //the principe is basic
              //we will create a container that will display the back face or the front face
              // and we will wrap it in a Transform widget
              //then we will make a tween animation for animating our card
              //now let's wrap our tween animation inside a gesture detector

              GestureDetector(
                onTap: _flip,
                child: TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: angle),
                    duration: const Duration(seconds: 1),
                    builder: (BuildContext context, double val, __) {
                      //here we will change the isBack val so we can change the content of the card
                      if (val >= (pi / 2)) {
                        isBack = false;
                      } else {
                        isBack = true;
                      }
                      return (Transform(
                        //let's make the card flip by it's center
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY(val),
                        child: SizedBox(
                            width: 500,
                            height: 380,
                            child: isBack
                                ? Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("lib/images/face.png"),
                                ),
                              ),
                            ) //if it's back we will display here
                                : Transform(
                                  alignment: Alignment.center,
                                  transform: Matrix4.identity()
                                ..rotateY(
                                    pi), // it will flip horizontally the container
                                child: Container(
                                  decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("lib/images/back.png"),
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    "I'm back",
                                    style: TextStyle(
                                      fontSize: 30.0,
                                    ),
                                  ),
                                ),
                              ),
                            ) //else we will display it here,
                        ),
                      ));
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}