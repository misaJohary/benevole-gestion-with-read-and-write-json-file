import '../screens/new_benevole_test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/benevole.dart';

class HomePageTest extends StatefulWidget {
  static String routeName = './hometest';
  @override
  _HomePageTestState createState() => _HomePageTestState();
}

class _HomePageTestState extends State<HomePageTest> {

  @override
  Widget build(BuildContext context) {
    final _benevole = Provider.of<BenevoleNotifier>(context).readBenevoles();

    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des bénévoles'),
        centerTitle: true,
      ),
     
      body: _benevole != null ?
          ListView.builder(
              itemBuilder: (context, index) {
                return Column(children: [
                  ListTile(
                    onTap: () {
                      // Navigator.of(context).pushNamed(DetailScreen.routeName,
                      //     arguments: _benevole.name[index]);
                    },
                    title: Text(_benevole.name[index]),
                    subtitle: Text(_benevole.number[index]),
                    trailing: Icon(Icons.arrow_forward_ios_rounded,  size: 18,color: Colors.grey),
                  ),
                  Divider()
                ]);
              },
              itemCount: 2) : Container(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(AddNewBenevoleTest.routeName);
        },
      ),
    );
  }
}
