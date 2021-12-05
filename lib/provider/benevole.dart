import '../file_manager.dart';
import 'package:flutter/material.dart';

class BenevoleFile {
  final List<String> id;
  final List<String> name;
  final List<String> number;
  final List<String> adresse;
  final List<String> email;
  final List<String> profession;
  final List<String> availability;

  BenevoleFile({
    this.id,
    this.name,
    this.number,
    this.adresse,
    this.email,
    this.profession,
    this.availability,
  });
  BenevoleFile.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        number = json['number'],
        adresse = json['adresse'],
        email = json['eamil'],
        profession = json['profession'],
        availability = json['availability'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'number': number,
        'adresse': adresse,
        'email': email,
        'profession': profession,
        'availability': availability,
      };
}

class BenevoleNotifier with ChangeNotifier {
  // List benevoles = [
  //   Benevole(
  //     id: 'b1',
  //     name: 'ANDRIAMALALA Falitiana',
  //     number: '0347992643',
  //     email: ' Falitiana37@gmail.com',
  //     adresse: 'Soavinimerina Avarandrano',
  //     profession: 'Environnementaliste GIZ',
  //     availability: 'Samedi',
  //   ),
  //   Benevole(
  //     id: 'b2',
  //     name: 'ANDRIANJAKA Nancy',
  //     number: '0344343882',
  //     email: 'nancy.andrianjaka@gmail.com',
  //     adresse: 'Analamahitsy',
  //     profession: 'Attachée de direction',
  //     availability: 'Samedi',
  //   ),
  //   Benevole(
  //     id: 'b3',
  //     name: 'RAZAFIMANANTSOA Hajarivony Rindra',
  //     number: '0345431170 ',
  //     email: 'hajarivonyr@gmail.com',
  //     adresse: 'Itaosy Hopitaly',
  //     profession: 'Directeur vente, Marketing et Partenariat',
  //     availability: 'Mercredi',
  //   ),
  //   Benevole(
  //     id: 'b4',
  //     name: 'RAJAONARIVELO Ranto',
  //     number: '0347029304',
  //     email: 'Rantorajaonarivelo521@gmail.com',
  //     adresse: 'Ambatokaranana',
  //     profession: 'Etudiant',
  //     availability: 'Mercredi',
  //   ),
  //   Benevole(
  //     id: 'b5',
  //     name: 'RAKOTOARIMANANA Anjaharivola Tendrisoa',
  //     number: '0348208958',
  //     email: 'rakotoarimananatendrisoa@gmail.com',
  //     adresse: 'Ambohidrapeto Itaosy',
  //     profession: 'Etudiante',
  //     availability: 'Samedi',
  //   ),
  // ];

  BenevoleFile _benevole;

  BenevoleFile get benevole => _benevole;

  readBenevoles() async {
    final result = await FileManager().readJsonFile();
    if (result != null) {
      _benevole = BenevoleFile.fromJson(await FileManager().readJsonFile());
      notifyListeners();
    return _benevole;
    }
    return null;
  }

  writeUser(BenevoleFile newBenevole) async {
    _benevole = await FileManager().writeJsonFile(newBenevole);
    notifyListeners();
  }

  // addNew(Benevole newBenevole) {
  //   // benevoles.insert(newBenevole);
  //   benevoles.add(newBenevole);
  //   notifyListeners();
  // }

  // editExisting(String editId, Benevole editBenevole) {
  //   int index;
  //   index = benevoles.indexWhere((element) => element.id == editId);
  //   benevoles[index] = editBenevole;
  //   notifyListeners();
  // }

  // deleteBenevole(String id) {
  //   benevoles.removeWhere((element) => element.id == id);
  //   notifyListeners();
  // }
}
