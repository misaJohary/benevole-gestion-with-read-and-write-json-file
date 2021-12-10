import '../provider/benevole.dart';
// import 'package:benevolat/provider/file_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddNewBenevoleTest extends StatefulWidget {
  static String routeName = './add-new-test';

  @override
  _AddNewBenevoleTestState createState() => _AddNewBenevoleTestState();
}

class _AddNewBenevoleTestState extends State<AddNewBenevoleTest> {
  final _form = GlobalKey<FormState>();
  // Benevole newBenevole = Benevole(
  //   id: DateTime.now().toString(),
  //   name: '',
  //   number: '',
  //   email: '',
  //   adresse: '',
  //   profession: '',
  //   availability: '',

  // );

  String _selectedDay;
  BenevoleFile _benevole = BenevoleFile(
      id: [],
      name: [],
      number: [],
      email: [],
      adresse: [],
      profession: [],
      availability: []);

  _saveForm() {
    _form.currentState.save();
  }

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
    context.select((BenevoleNotifier controller) =>
        controller.benevole != null ? _benevole = controller.benevole : null);
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un nouveau membre'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nom et Prénom : '),
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  _benevole.id.add(DateTime.now().toString());
                  _benevole.name.add(value);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Contact : '),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
                onSaved: (value) {
                  _benevole.number.add(value);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'E-mail : '),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                onSaved: (value) {
                  _benevole.email.add(value);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Adresse : '),
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  _benevole.adresse.add(value);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Profession : '),
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  _benevole.profession.add(value);
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
                      _benevole.availability.add(value);
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
                  _saveForm();
                  context.read<BenevoleNotifier>().writeUser(_benevole);
                  // Provider.of<BenevoleNotifier>(context, listen: false)
                  //     .writeUser(_benevole);
                  // Navigator.of(context).pop();
                },
                child: Text('Enregistrer'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
