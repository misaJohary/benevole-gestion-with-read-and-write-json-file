import './new_benevole_test.dart';
import './detail_screen.dart';
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
    // final _benevole = Provider.of<BenevoleNotifier>(context).readBenevoles();

    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des bénévoles'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: Search());
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: context
          .select((BenevoleNotifier controller) => controller.benevole != null
              ? ListView.builder(
                  itemBuilder: (context, index) {
                    return Column(children: [
                      ListTile(
                        onTap: () {
                          Navigator.of(context).pushNamed(DetailScreen.routeName,
                              arguments: controller.benevole.id[index]);
                        },
                        title: Text(controller.benevole.name[index]),
                        subtitle: Text(controller.benevole.number[index]),
                        trailing: Icon(Icons.arrow_forward_ios_rounded,
                            size: 18, color: Colors.grey),
                      ),
                      Divider()
                    ]);
                  },
                  itemCount: controller.benevole.name.length)
              : Container(child: Center(child: Text('Nothing to print here'),),)),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(AddNewBenevoleTest.routeName);
        },
      ),
    );
  }
}

class Search extends SearchDelegate {

  // bool groupBy;

  // Search(this.groupBy);

  List result = [];
  List numberSuggest = [];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leading icon on the left of the appBar
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView.builder(
      itemCount: result.length,
      itemBuilder: (context, index) {
        return Column(children: [
                  ListTile(
                    onTap: () {
                      // Navigator.of(context).pushNamed(DetailScreen.routeName,
                      //     arguments: result[index].id);
                    },
                    title: Text(result[index]),
                    subtitle: Text(numberSuggest[index]),
                  ),
                  Divider()
                ]);
        // return ListTile(
        //   title: result[index].name,
        //   subtitle: result[index].number,
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searches for something

    BenevoleFile _benevole = BenevoleFile(
      id: [],
      name: [],
      number: [],
      email: [],
      adresse: [],
      profession: [],
      availability: []);

    context.select(
        (BenevoleNotifier controller) => controller.benevole != null? _benevole = controller.benevole : null);
 
    var result = _benevole.name.where((element) => element.contains(RegExp("$query", caseSensitive: false))).toList();
    var index = [];
    List idSuggest = [];
    

    for(var i = 0; i<result.length; i++){
      index.add(_benevole.name.indexWhere((element) => element == result[i]));
      idSuggest.add(_benevole.id[index[i]]);
      numberSuggest.add(_benevole.number[index[i]]);
    }

    return query.isEmpty
        ? Container()
        : ListView.builder(
            itemCount: result.length,
            itemBuilder: (context, index) => ListTile(
              onTap: () {
                Navigator.of(context).pushNamed(
                  DetailScreen.routeName,
                    arguments: idSuggest[index]
                    );
                // showResults(context);
              },
              title: Text(result[index]),
              subtitle: Text(numberSuggest[index]),
            ),
          );
    // throw UnimplementedError();
  }
}