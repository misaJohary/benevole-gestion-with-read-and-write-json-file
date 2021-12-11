import 'package:flutter/material.dart';
import 'screens/benevole_list.dart';
// import './screens/note_detail.dart';

void main() {
	runApp(MyApp());
}

class MyApp extends StatelessWidget {

	@override
  Widget build(BuildContext context) {

    return MaterialApp(
	    title: 'Gestionnaire de benevole',
	    debugShowCheckedModeBanner: false,
	    theme: ThemeData(
		    primarySwatch: Colors.blue
	    ),
	    home: BenevoleList(),
    );
  }
}