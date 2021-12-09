import 'package:downgrade/search.dart';

import './new_benevole_test.dart';
import './detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import '../provider/benevole.dart';
import '../core/const.dart';

class HomePageTest extends StatefulWidget {
  static String routeName = './hometest';
  @override
  _HomePageTestState createState() => _HomePageTestState();
}

class _HomePageTestState extends State<HomePageTest> {
  bool _groupByAvaibility = false;
  bool _showEmpty = false;

  List<String> _day = Data.day;

  List<MaterialColor> _color = Data.color;

  List<String> _selectedDay = Data.selectedDay;

  BenevoleFile _benevole = Data.benevole;

  @override
  Widget build(BuildContext context) {
    // final _benevole = Provider.of<BenevoleNotifier>(context).readBenevoles();

    context.select((BenevoleNotifier controller) =>
        controller.benevole != null ? _benevole = controller.benevole : null);

    List<Benevole> benTemp = generateBenevoleList().toList();

    List _days = List.generate(
      _selectedDay.length,
      (index) => benTemp
          .where((element) => element.availability == _selectedDay[index])
          .toList(),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des bénévoles'),
        centerTitle: true,
        actions: [
          _groupByAvaibility
              ? IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return MultiSelectDialog(
                            height: MediaQuery.of(context).size.height * (0.6),
                            title: Text('Filtrer par disponibilité'),
                            searchable: false,
                            items:
                                _day.map((e) => MultiSelectItem(e, e)).toList(),
                            initialValue: _selectedDay,
                            onConfirm: (value) {
                              setState(() {
                                _selectedDay = value;
                              });
                            },
                          );
                        });
                  },
                  icon: Icon(Icons.filter_list_alt))
              : IconButton(
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
                        onPressed: () {},
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
              SwitchListTile(
                  title: Text('Grouper par disponibilité'),
                  value: _groupByAvaibility,
                  onChanged: (value) {
                    setState(() {
                      _groupByAvaibility = value;
                    });
                  }),
              SwitchListTile(
                  title: Text('Afficher tout les jours'),
                  value: _showEmpty,
                  onChanged: (value) {
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
              ? ListWithAvailability(days: _days, showEmpty: _showEmpty, selectedDay: _selectedDay, color: _color)
              : ListWithoutAvailability(controller.benevole)
          : NothingToPrint()),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(AddNewBenevoleTest.routeName);
        },
      ),
    );
  }

  List<Benevole> generateBenevoleList() {
    return List.generate(
    _benevole.id.length,
    (index) => Benevole(
      id: _benevole.id[index],
      name: _benevole.name[index],
      adresse: _benevole.adresse[index],
      number: _benevole.number[index],
      availability: _benevole.availability[index],
      profession: _benevole.profession[index],
    ),
  );
  }
}

class NothingToPrint extends StatelessWidget {
  const NothingToPrint({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
          child: Text('Nothing to print here'),
        ),
      );
  }
}

class ListWithoutAvailability extends StatelessWidget {

  final BenevoleFile benevole;

  ListWithoutAvailability(
    this.benevole,
  );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, index) {
          return Column(children: [
            ListTile(
              onTap: () {
                Navigator.of(context).pushNamed(
                    DetailScreen.routeName,
                    arguments: benevole.id[index]);
              },
              title: Text(benevole.name[index]),
              subtitle: Text(benevole.number[index]),
              trailing: Icon(Icons.arrow_forward_ios_rounded,
                  size: 18, color: Colors.grey),
            ),
            Divider()
          ]);
        },
        itemCount: benevole.name.length);
  }
}

class ListWithAvailability extends StatelessWidget {
  const ListWithAvailability({
    Key key,
    @required List days,
    @required bool showEmpty,
    @required List<String> selectedDay,
    @required List<MaterialColor> color,
  }) : _days = days, _showEmpty = showEmpty, _selectedDay = selectedDay, _color = color, super(key: key);

  final List _days;
  final bool _showEmpty;
  final List<String> _selectedDay;
  final List<MaterialColor> _color;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                                      _selectedDay[i],
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
      );
  }
}


