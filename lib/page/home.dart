import 'package:easy_localization/easy_localization.dart';
import 'package:af_test/page//menu.dart';
import 'package:af_test/page/page_structure.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static List<MenuItem> mainMenu = [
    MenuItem(tr("history"), 0),
    MenuItem(tr("geography"), 1),
    MenuItem(tr("SVT"), 2),
    MenuItem(tr("philosophy"), 3),
    MenuItem(tr("physics_chemical"), 4),
    MenuItem(tr("math"), 5),
  ];

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _drawerController = ZoomDrawerController();

  final int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: _drawerController,
      menuScreen: MenuScreen(
        HomeScreen.mainMenu,
        callback: _updatePage,
        current: _currentPage,
      ),
      mainScreen: const MainScreen(),
      openCurve: Curves.fastOutSlowIn,
      style: DrawerStyle.Style1,
      showShadow: true,
      mainScreenScale: .3,
      angle: 0.0,
      swipeOffset: 2.0,
      slideWidth: MediaQuery.of(context).size.width*.65,
    );
  }

  void _updatePage(index) {
    Provider.of<MenuProvider>(context, listen: false).updateCurrentPage(index);
    _drawerController.toggle?.call();
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<DrawerState>(
      valueListenable: ZoomDrawer.of(context)!.stateNotifier!,
      builder: (context, state, child) {
        return AbsorbPointer(
          absorbing: state != DrawerState.closed,
          child: child,
        );
      },
      child: GestureDetector(
        child: const PageStructure(),
        onPanUpdate: (details) {
          if (details.delta.dx < 6 ) {
            ZoomDrawer.of(context)?.toggle.call();
          }
        },
      ),
    );
  }
}

class MenuProvider extends ChangeNotifier {
  int _currentPage = 0;

  int get currentPage => _currentPage;

  void updateCurrentPage(int index) {
    if (index != currentPage) {
      _currentPage = index;
      notifyListeners();
    }
  }
}

