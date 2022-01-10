import 'package:easy_localization/easy_localization.dart';
import 'package:af_test/page/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      child: const MyApp(),
      path: 'assets/lang',
      supportedLocales: MyApp.list,
      saveLocale: true,
      useOnlyLangCode: true,
    ),
  );
}

class MyApp extends StatelessWidget {
  static const list = [
    Locale('fr')
  ];

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Zoom Drawer Demo',
      onGenerateTitle: (context) => tr("app_name"),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,

      home: ChangeNotifierProvider(
        create: (_) => MenuProvider(),
        child: const HomeScreen(),
      ),
    );
  }
}
