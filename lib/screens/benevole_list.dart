import 'dart:async';
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
	    ),

	    body: getNoteListView(),

	    floatingActionButton: FloatingActionButton(
		    onPressed: () {
		      // debugPrint('FAB clicked');
		      navigateToDetail(Benevole('', '', '', '', '', ''), 'Add Benevole');
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
				return Card(
					color: Colors.white,
					elevation: 2.0,
					child: ListTile(

						// leading: CircleAvatar(
						// 	backgroundColor: getPriorityColor(this.benevoleList[position].priority),
						// 	child: getPriorityIcon(this.benevoleList[position].priority),
						// ),

						title: Text(this.benevoleList[position].name,),

						subtitle: Text(this.benevoleList[position].number, style: titleStyle,),

						trailing: GestureDetector(
							child: Icon(Icons.delete, color: Colors.grey,),
							onTap: () {
								_delete(context, benevoleList[position]);
							},
						),


						onTap: () {
							debugPrint("ListTile Tapped");
							navigateToDetail(this.benevoleList[position],'Edit Benevole');
						},

					),
				);
			},
		);
  }

  // Returns the priority color
	// Color getPriorityColor(int priority) {
	// 	switch (priority) {
	// 		case 1:
	// 			return Colors.red;
	// 			break;
	// 		case 2:
	// 			return Colors.yellow;
	// 			break;

	// 		default:
	// 			return Colors.yellow;
	// 	}
	// }

	// Returns the priority icon
	// Icon getPriorityIcon(int priority) {
	// 	switch (priority) {
	// 		case 1:
	// 			return Icon(Icons.play_arrow);
	// 			break;
	// 		case 2:
	// 			return Icon(Icons.keyboard_arrow_right);
	// 			break;

	// 		default:
	// 			return Icon(Icons.keyboard_arrow_right);
	// 	}
	// }

	void _delete(BuildContext context, Benevole benevole) async {

		int result = await databaseHelper.deleteBenevole(benevole.id);
		if (result != 0) {
			_showSnackBar(context, 'Benevole Deleted Successfully');
			updateListView();
		}
	}

	void _showSnackBar(BuildContext context, String message) {

		final snackBar = SnackBar(content: Text(message));
		Scaffold.of(context).showSnackBar(snackBar);
	}

  void navigateToDetail(Benevole benevole, String title) async {
	  bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
		  return AddNewBenevoleTest(benevole, title);
	  }));

	  if (result == true) {
	  	updateListView();
	  }
  }

  void updateListView() {

		final Future<Database> dbFuture = databaseHelper.initializeDatabase();
		dbFuture.then((database) {

			Future<List<Benevole>> benevoleListFuture = databaseHelper.getBenevoleList();
			benevoleListFuture.then((benevoleList) {
				setState(() {
				  this.benevoleList = benevoleList;
				  this.count = benevoleList.length;
				});
			});
		});
  }
}







