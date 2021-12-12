import 'dart:async';
import 'package:downgrade/screens/detail_screen.dart';
import 'package:downgrade/screens/new_benevole_test.dart';
import 'package:flutter/material.dart';
import '../models/benevole.dart';
import '../utils/database_helper.dart';
import '../core/data.dart';
// import '../screens/note_detail.dart';
import 'package:sqflite/sqflite.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class BenevoleList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BenevoleListState();
  }
}

class BenevoleListState extends State<BenevoleList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Benevole> benevoleList;
  int count = 0;
  List<String> _day = Data.day;
  List<String> _selectedDay = Data.selectedDay;
  List<MaterialColor> _color = Data.color;
  List _days = [];

  @override
  Widget build(BuildContext context) {
    if (benevoleList == null) {
      benevoleList = List<Benevole>();
      updateListView();
    }

    _days = List.generate(
        _selectedDay.length,
        (index) => benevoleList.where(
            (element) => element.availability == _selectedDay[index]).toList()).toList();

    // _days = [
    //   benevoleList.where((element) => element.availability == 'Lundi').toList(),
    //   benevoleList.where((element) => element.availability == 'Mardi').toList(),
    //   benevoleList
    //       .where((element) => element.availability == 'Mercredi')
    //       .toList(),
    //   benevoleList.where((element) => element.availability == 'Jeudi').toList(),
    //   benevoleList
    //       .where((element) => element.availability == 'Vendredi')
    //       .toList(),
    //   benevoleList
    //       .where((element) => element.availability == 'Samedi')
    //       .toList(),
    //   benevoleList
    //       .where((element) => element.availability == 'Dimanche')
    //       .toList(),
    // ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Benevoles'),
        actions: [
          Data.groupByAvaibility
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
                    showSearch(
                        context: context,
                        delegate: Search(benevoleList, navigateToDetail));
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
                  value: Data.groupByAvaibility,
                  onChanged: (value) {
                    setState(() {
                      Data.groupByAvaibility = value;
                    });
                  }),
              SwitchListTile(
                  title: Text('Afficher tout les jours'),
                  value: false,
                  onChanged: (value) {
                    // setState(() {
                    //   Data.showEmpty = value;
                    // });
                  }),
            ],
          ),
        ),
      ),
      body: getNoteListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // debugPrint('FAB clicked');
          navigateToAdd(Benevole('', '', '', '', '', ''), 'Add Benevole');
        },
        tooltip: 'Add Benevole',
        child: Icon(Icons.add),
      ),
    );
  }

  getNoteListView() {
    TextStyle titleStyle = Theme.of(context).textTheme.caption;

    return Data.groupByAvaibility
        ? SingleChildScrollView(
            child: Column(
                children: List.generate(
              _days.length,
              (i) => _days[i].length == 0
                  ? Data.showEmpty
                      ? Container(
                          margin: EdgeInsets.all(10),
                          height: 70,
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                    navigateToDetail(_days[i][index]);
                                    // Navigator.of(context).pushNamed(
                                    //     DetailScreen.routeName,
                                    //     arguments: _days[i][index].id);
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
            itemCount: count,
            itemBuilder: (BuildContext context, int position) {
              return Column(
                children: [
                  ListTile(
                    // leading: CircleAvatar(
                    // 	backgroundColor: getPriorityColor(this.benevoleList[position].priority),
                    // 	child: getPriorityIcon(this.benevoleList[position].priority),
                    // ),

                    title: Text(
                      this.benevoleList[position].name,
                    ),

                    subtitle: Text(
                      this.benevoleList[position].number,
                      style: titleStyle,
                    ),

                    trailing: Icon(Icons.arrow_forward_ios_rounded,
                        size: 18, color: Colors.grey),

                    onTap: () {
                      debugPrint("ListTile Tapped");
                      navigateToDetail(this.benevoleList[position]);
                    },
                  ),
                  Divider()
                ],
              );
            },
          );
  }

  void navigateToAdd(Benevole benevole, String title) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddNewBenevoleTest(benevole, title);
    }));

    if (result == true) {
      updateListView();
    }
  }

  void navigateToDetail(Benevole benevole) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return DetailScreen(benevole);
    }));

    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Benevole>> benevoleListFuture =
          databaseHelper.getBenevoleList();
      benevoleListFuture.then((benevoleList) {
        setState(() {
          this.benevoleList = benevoleList;
          this.count = benevoleList.length;
        });
      });
    });
  }
}

class Search extends SearchDelegate {
  List<Benevole> benevoles;
  Function navigateToDetail;

  Search(this.benevoles, this.navigateToDetail);

  var result;

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    // throw UnimplementedError();
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
    );
    // throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return query.isEmpty
        ? Container()
        : ListView.builder(
            itemCount: result.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(result[index].name),
                subtitle: Text(result[index].number),
              );
            },
          );

    // throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    result = benevoles
        .where(
          (element) => element.name.contains(
            RegExp(
              '$query',
              caseSensitive: false,
            ),
          ),
        )
        .toList();

    return query.isEmpty
        ? Container()
        : ListView.builder(
            itemCount: result.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(result[index].name),
                subtitle: Text(result[index].number),
                onTap: () {
                  navigateToDetail(result[index]);
                },
              );
            });
// throw UnimplementedError();
  }
}
