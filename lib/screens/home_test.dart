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
  bool _groupByAvaibility = false;
  bool _showEmpty = false;
  final List<String> _day = [
    'Lundi',
    'Mardi',
    'Mercredi',
    'Jeudi',
    'Vendredi',
    'Samedi',
    'Dimanche'
  ];
  BenevoleFile _benevole = BenevoleFile(
      id: [],
      name: [],
      number: [],
      email: [],
      adresse: [],
      profession: [],
      availability: []);

  final List<MaterialColor> _color = [
    Colors.cyan,
    Colors.purple,
    Colors.orange,
    Colors.lightGreen,
    Colors.pink,
    Colors.brown,
    Colors.amber
  ];
  @override
  Widget build(BuildContext context) {
    // final _benevole = Provider.of<BenevoleNotifier>(context).readBenevoles();

    context.select((BenevoleNotifier controller) =>
        controller.benevole != null ? _benevole = controller.benevole : null);

    List<Benevole> benTemp = List.generate(
      _benevole.id.length,
      (index) => Benevole(
        id: _benevole.id[index],
        name: _benevole.name[index],
        adresse: _benevole.adresse[index],
        number: _benevole.number[index],
        availability: _benevole.availability[index],
        profession: _benevole.profession[index],
      ),
    ).toList();

    List _days = [
      benTemp.where((element) => element.availability == 'Lundi').toList(),
      benTemp.where((element) => element.availability == 'Mardi').toList(),
      benTemp.where((element) => element.availability == 'Mercredi').toList(),
      benTemp.where((element) => element.availability == 'Jeudi').toList(),
      benTemp.where((element) => element.availability == 'Vendredi').toList(),
      benTemp.where((element) => element.availability == 'Samedi').toList(),
      benTemp.where((element) => element.availability == 'Dimanche').toList(),
    ];

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
      drawer: SafeArea(
        child: Drawer(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 150,
                decoration:
                    BoxDecoration(color: Theme.of(context).primaryColor),
                child: Stack(
                  children: [
                    Positioned(
                      left: 50,
                      bottom: 20,
                      width: 200,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text('Bienvenue',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(color: Colors.white),
                            softWrap: true,
                            overflow: TextOverflow.clip),
                      ),
                    ),
                    Positioned(
                      top: 5,
                      right: 5,
                      child: IconButton(
                        onPressed: () {

                        },
                        icon: Icon(
                          Icons.info_outline,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SwitchListTile(title: Text('Grouper par disponibilité'),value: _groupByAvaibility, onChanged: (value){
                setState(() {
                  _groupByAvaibility = value;
                });
              }),
              SwitchListTile(title: Text('Afficher tout les jours'), value: _showEmpty, onChanged: (value){
                setState(() {
                  _showEmpty = value;
                });
              }),
            ],
          ),
        ),
      ),
      body: context.select((BenevoleNotifier controller) => controller
                  .benevole !=
              null
          ? _groupByAvaibility
              ? SingleChildScrollView(
                  child: Column(
                      children: List.generate(
                    _days.length,
                    (i) => _days[i].length == 0
                        ? _showEmpty
                            ? Container(
                                margin: EdgeInsets.all(10),
                                height: 70,
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Container(
                                            child: Center(
                                              child: Text(
                                                _day[i],
                                                overflow: TextOverflow.fade,
                                                softWrap: false,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption
                                                    .copyWith(
                                                        color: Colors.white,
                                                        fontSize: 15),
                                              ),
                                            ),
                                            color: _color[i],
                                            height: double.infinity,
                                          )),
                                      Expanded(
                                          flex: 5,
                                          child: Container(
                                            color: Colors.black12,
                                            child: Center(
                                                child: Text(
                                              'Aucune personne Disponible',
                                              style: TextStyle(
                                                  fontStyle: FontStyle.italic),
                                            )),
                                          )),
                                    ]),
                              )
                            : Container()
                        : Container(
                            margin: EdgeInsets.all(10),
                            height: _days[i].length * 70.0,
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                        child: Center(
                                          child: Text(
                                            _days[i][0].availability,
                                            overflow: TextOverflow.fade,
                                            softWrap: false,
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption
                                                .copyWith(
                                                    color: Colors.white,
                                                    fontSize: 15),
                                          ),
                                        ),
                                        color: _color[i],
                                        height: double.infinity,
                                      )),
                                  Expanded(
                                    flex: 5,
                                    child: ListView.builder(
                                      itemCount: _days[i].length,
                                      itemBuilder: (ctx, index) => ListTile(
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                              DetailScreen.routeName,
                                              arguments: _days[i][index].id);
                                        },
                                        title: Text(_days[i][index].name),
                                        subtitle: Text(_days[i][index].number),
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                  ).toList()),
                )
              : ListView.builder(
                  itemBuilder: (context, index) {
                    return Column(children: [
                      ListTile(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              DetailScreen.routeName,
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
          : Container(
              child: Center(
                child: Text('Nothing to print here'),
              ),
            )),
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
