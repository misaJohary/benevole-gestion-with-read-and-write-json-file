// import 'package:downgrade/screens/edit_screen.dart';
import 'package:downgrade/models/benevole.dart';
import 'package:downgrade/screens/new_benevole_test.dart';
import 'package:downgrade/utils/database_helper.dart';
import 'package:downgrade/widgets/info.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  static String routeName = './detail-screen';
  final Benevole benevole;

  DetailScreen(this.benevole);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  DatabaseHelper helper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: (){
        Navigator.of(context).pop(true);
      },
      child: Scaffold(
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(30)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 5),
                            blurRadius: 10)
                      ]),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                              icon: Icon(
                                Icons.arrow_back_rounded,
                              ),
                              color: Colors.white),
                          IconButton(
                              onPressed: () {
                                // Navigator.of(context).pushNamed(
                                //     EditScreen.routeName,
                                //     arguments: args);
                                navigateToAdd(widget.benevole, 'Editer', context);
                              },
                              icon: Icon(Icons.edit),
                              color: Colors.white),
                        ],
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            widget.benevole.name,
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Info(
                          title: 'Contact',
                          info: widget.benevole.number,
                        ),
                        Info(
                          title: 'E-mail',
                          info: widget.benevole.email,
                        ),
                        Info(
                          title: 'Adresse',
                          info: widget.benevole.adresse,
                        ),
                        Info(
                          title: 'Profession',
                          info: widget.benevole.profession,
                        ),
                        Info(
                          title: 'Disponibilité',
                          info: widget.benevole.availability,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.delete_rounded),
              onPressed: () {
                // Navigator.of(context).pop();
                _delete(context, widget.benevole);
              },
              splashColor: Colors.red)),
    );
  }

  void moveToLastScreen(BuildContext context) {
    Navigator.pop(context, true);
  }

  void _delete(BuildContext context, Benevole benevole) async {
    moveToLastScreen(context);
    int result = await helper.deleteBenevole(benevole.id);
    if (result != 0) {
      // _showSnackBar(context, 'Benevole Deleted Successfully');
      // updateListView();
      _showAlertDialog('Status', 'Benevole Deleted Successfully', context);
    } else {
      // Failure
      _showAlertDialog('Status', 'Problem Deleting Benevole', context);
    }
  }

  void _showAlertDialog(String title, String message, BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  void navigateToAdd(Benevole benevole, String title, BuildContext context) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddNewBenevoleTest(benevole, title);
    }));

    if (result == true) {
      setState(() {
        
      });
    }
  }
}
