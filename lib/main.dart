import './provider/benevole.dart';
// import 'package:benevolat/provider/file_controller.dart';
import './screens/new_benevole_test.dart';
import './screens/home_test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BenevoleNotifier(),
        ),

      ],
      child: MaterialApp(
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
        },
      ),
    );
  }
}
