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
                          // Navigator.of(context).pushNamed(DetailScreen.routeName,
                          //     arguments: _benevole.name[index]);
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
                    // subtitle: Text(result[index].number),
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

    // final benevole = Provider.of<BenevoleNotifier>(context, listen: false);
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


    
    result = _benevole.name.where((element) => element.contains(RegExp("$query", caseSensitive: false))).toList();
    // result = _benevole
    //     .where((element) =>
    //         element.name.contains(RegExp("$query", caseSensitive: false)))
    //     .toList();

    return query.isEmpty
        ? Container()
        : ListView.builder(
            itemCount: result.length,
            itemBuilder: (context, index) => ListTile(
              onTap: () {
                // Navigator.of(context).pushNamed(
                //   DetailScreen.routeName,
                //     arguments: result[index].id
                //     );
                // showResults(context);
              },
              title: Text(result[index]),
              // subtitle: Text(result[index].number),
            ),
          );
    // throw UnimplementedError();
  }
}