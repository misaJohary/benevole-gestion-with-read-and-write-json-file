import './provider/benevole.dart';
// import 'package:benevolat/provider/file_controller.dart';
import './screens/new_benevole_test.dart';
import './screens/home_test.dart';
// import './screens/edit_screen.dart';
import './screens/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => BenevoleNotifier(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<BenevoleNotifier>().readBenevoles();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePageTest(),
      // home: GetStarted(),
      // home: HomePage(),
      routes: {
        AddNewBenevoleTest.routeName: (ctx) => AddNewBenevoleTest(),
        DetailScreen.routeName: (ctx) => DetailScreen(),
        // EditScreen.routeName: (ctx) => EditScreen(),
      },
    );
  }
}
