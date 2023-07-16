import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:p01/view/splash.screen.dart';
import 'package:provider/provider.dart';
import 'package:p01/providers/prov.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => Prov())],
    child: const App(),
  ));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: SplashView(),
    );
  }
}
