import 'dart:async';
import 'package:downgrade/screens/detail_screen.dart';
import 'package:downgrade/screens/new_benevole_test.dart';
import 'package:flutter/material.dart';
import '../models/benevole.dart';
import '../utils/database_helper.dart';
// import '../screens/note_detail.dart';
import 'package:sqflite/sqflite.dart';

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

  @override
  Widget build(BuildContext context) {
    if (benevoleList == null) {
      benevoleList = List<Benevole>();
      updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Benevoles'),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: Search(benevoleList));
            },
            icon: Icon(Icons.search),
          )
        ],
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

  ListView getNoteListView() {
    TextStyle titleStyle = Theme.of(context).textTheme.caption;

    return ListView.builder(
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

  Search(this.benevoles);

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
              );
            });
// throw UnimplementedError();
  }
}
