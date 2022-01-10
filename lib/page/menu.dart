import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:af_test/page/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatefulWidget {
  final List<MenuItem> mainMenu;
  final Function(int)? callback;
  final int? current;

const MenuScreen(
      this.mainMenu, {
        Key? key,
        this.callback,
        this.current,
      });

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final widthBox = const SizedBox(
    width: 16.0,
  );

  @override
  Widget build(BuildContext context) {
    const TextStyle androidStyle = TextStyle(
        fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white);
    const TextStyle iosStyle = TextStyle(color: Colors.white);
    final style = kIsWeb
        ? androidStyle
        : Platform.isAndroid
        ? androidStyle
        : iosStyle;

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              Colors.indigo,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Spacer(),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 36.0, left: 24.0, right: 24.0),
                  child: Text(
                    tr("Afterclasse"),
                    style: const TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Selector<MenuProvider, int>(
                  selector: (_, provider) => provider.currentPage,
                  builder: (_, index, __) => Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ...widget.mainMenu
                          .map((item) => MenuItemWidget(
                        key: Key(item.index.toString()),
                        item: item,
                        callback: widget.callback,
                        widthBox: widthBox,
                        style: style,
                        selected: index == item.index,
                      ))
                          .toList()
                    ],
                  ),
                ),

                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.settings, color: Colors.white),
                      tooltip: 'Increase volume by 10',
                      onPressed: () {
                        showCupertinoModalPopup<void>(
                          context: context,
                          builder: (BuildContext context) => CupertinoActionSheet(
                            actions: <CupertinoActionSheetAction>[
                              CupertinoActionSheetAction(
                                child: const Text('3ème'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              CupertinoActionSheetAction(
                                child: const Text('Terminale L'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              CupertinoActionSheetAction(
                                child: const Text('Terminale ES'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              CupertinoActionSheetAction(
                                child: const Text('Terminale S'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          ),
                        );
                      },
                    ),
                    const Text(
                      "Paramètres",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MenuItemWidget extends StatelessWidget {
  final MenuItem? item;
  final Widget? widthBox;
  final TextStyle? style;
  final Function? callback;
  final bool? selected;

  final white = Colors.white;

  const MenuItemWidget({
    Key? key,
    this.item,
    this.widthBox,
    this.style,
    this.callback,
    this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => callback!(item!.index),
      style: TextButton.styleFrom(
        primary: selected! ? Color(0x44000000) : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          widthBox!,
          Expanded(
            child: Text(
              item!.title,
              style: style,
            ),
          )
        ],
      ),
    );
  }
}

class MenuItem {
  final String title;
  final int index;

  const MenuItem(this.title, this.index);
}