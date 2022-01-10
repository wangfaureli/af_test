import 'package:flutter/material.dart';

import 'flip.dart';

class CardView extends StatelessWidget {
  const CardView({
    Key? key,
    this.text = "Card View",
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: <Widget>[
          const SizedBox.expand(
            child: FlipCard(),
          ),

          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(text,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700)),
                    const Padding(padding: EdgeInsets.only(bottom: 30.0)),
                    Text("$text details",
                        textAlign: TextAlign.start,
                        style: const TextStyle(color: Colors.white)),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
