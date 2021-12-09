import 'package:flutter/material.dart';
import './provider/benevole.dart';
import 'screens/detail_screen.dart';
import 'package:provider/provider.dart';

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

    context.select((BenevoleNotifier controller) =>
        controller.benevole != null ? _benevole = controller.benevole : null);

    var result = _benevole.name
        .where((element) =>
            element.contains(RegExp("$query", caseSensitive: false)))
        .toList();
    var index = [];
    List idSuggest = [];

    for (var i = 0; i < result.length; i++) {
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
                Navigator.of(context).pushNamed(DetailScreen.routeName,
                    arguments: idSuggest[index]);
                // showResults(context);
              },
              title: Text(result[index]),
              subtitle: Text(numberSuggest[index]),
            ),
          );
    // throw UnimplementedError();
  }
}