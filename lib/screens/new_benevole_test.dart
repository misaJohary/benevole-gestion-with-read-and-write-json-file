// import 'package:benevolat/provider/file_controller.dart';
import 'package:downgrade/models/benevole.dart';
import 'package:downgrade/utils/database_helper.dart';
import 'package:flutter/material.dart';

class AddNewBenevoleTest extends StatefulWidget {
  static String routeName = './add-new-test';
  final String appBarTitle;
	final Benevole benevole;

	AddNewBenevoleTest(this.benevole, this.appBarTitle);

  @override
  _AddNewBenevoleTestState createState() => _AddNewBenevoleTestState();
  // _AddNewBenevoleTestState createState() => _AddNewBenevoleTestState(this.benevole, this.appBarTitle);
}

class _AddNewBenevoleTestState extends State<AddNewBenevoleTest> {
  final _form = GlobalKey<FormState>();

  DatabaseHelper helper = DatabaseHelper();

  // String appBarTitle;
	// Benevole benevole;

  // _AddNewBenevoleTestState(Benevole benevole, String appBarTitle);


  String _selectedDay;

  @override
  void initState () {
    if(widget.benevole.availability != '')
    _selectedDay = widget.benevole.availability;
    super.initState();
  }

  // _saveForm() {
  //   _form.currentState.save();
  // }

  List<String> _day = [
    "Lundi",
    "Mardi",
    "Mercredi",
    "Jeudi",
    "Vendredi",
    "Samedi",
    "Dimanche"
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        moveToLastScreen();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.appBarTitle),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _form,
            child: ListView(
              children: [
                TextFormField(
                  initialValue: widget.benevole.name,
                  decoration: InputDecoration(labelText: 'Nom et Prénom : '),
                  textInputAction: TextInputAction.next,
                  onSaved: (value) {
                    updateName(value);
                  },
                ),
                TextFormField(
                  initialValue: widget.benevole.number,
                  decoration: InputDecoration(labelText: 'Contact : '),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.phone,
                  onSaved: (value) {
                    updateNumber(value);
                  },
                ),
                TextFormField(
                  initialValue: widget.benevole.email,
                  decoration: InputDecoration(labelText: 'E-mail : '),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value) {
                    updateEmail(value);
                  },
                ),
                TextFormField(
                  initialValue: widget.benevole.adresse,
                  decoration: InputDecoration(labelText: 'Adresse : '),
                  textInputAction: TextInputAction.next,
                  onSaved: (value) {
                    updateAdresse(value);
                  },
                ),
                TextFormField(
                  initialValue: widget.benevole.profession,
                  decoration: InputDecoration(labelText: 'Profession : '),
                  textInputAction: TextInputAction.next,
                  onSaved: (value) {
                    updateProfession(value);
                  },
                ),
                DropdownButtonFormField(
                    // isDense: false,
                    // menuMaxHeight: 100,
                    hint: Text('Disponibilité'),
                    value: _selectedDay,
                    decoration: InputDecoration(),
                    onChanged: (value) {
                      setState(() {
                        _selectedDay = value;
                        updateAvailability(value);
                      });
                    },
                    items: _day
                        .map((e) => DropdownMenuItem(
                              child: Text(e),
                              value: e,
                            ))
                        .toList()),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  onPressed: () {
                    _form.currentState.save();
                    _saveForm();
                  },
                  child: Text('Enregistrer'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  void updateName(String newName){
    widget.benevole.name = newName;
  }

	void updateNumber(String newNumber) {
		widget.benevole.number = newNumber;
	}

  void updateEmail(String newEmail) {
		widget.benevole.email = newEmail;
	}

  void updateAdresse(String newAdresse) {
		widget.benevole.adresse = newAdresse;
	}

  void updateProfession(String newProfession) {
		widget.benevole.profession = newProfession;
	}

  void updateAvailability(String newAvailability) {
		widget.benevole.availability = newAvailability;
	}

  void moveToLastScreen() {
		Navigator.pop(context, true);
  }

  void _saveForm() async {

		moveToLastScreen();
		int result;
		if (widget.benevole.id != null) {  // Case 1: Update operation
			result = await helper.updateBenevole(widget.benevole);
		} else { // Case 2: Insert Operation
			result = await helper.insertBenevole(widget.benevole);
		}

		if (result != 0) {  // Success
			_showAlertDialog('Status', 'Benevole Saved Successfully');
		} else {  // Failure
			_showAlertDialog('Status', 'Problem Saving Benevole');
    }
	}
  
  void _showAlertDialog(String title, String message) {

		AlertDialog alertDialog = AlertDialog(
			title: Text(title),
			content: Text(message),
		);
		showDialog(
				context: context,
				builder: (_) => alertDialog
		);
	}

  // 	void _delete() async {

	// 	moveToLastScreen();

	// 	// Case 1: If user is trying to delete the NEW NOTE i.e. he has come to
	// 	// the detail page by pressing the FAB of NoteList page.
	// 	if (benevole.id == null) {
	// 		_showAlertDialog('Status', 'No Benevole was deleted');
	// 		return;
	// 	}

	// 	// Case 2: User is trying to delete the old benevole that already has a valid ID.
	// 	int result = await helper.deleteBenevole(benevole.id);
	// 	if (result != 0) {
	// 		_showAlertDialog('Status', 'Benevole Deleted Successfully');
	// 	} else {
	// 		_showAlertDialog('Status', 'Error Occured while Deleting Benevole');
	// 	}
	// }

}
