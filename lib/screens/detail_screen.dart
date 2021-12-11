// import 'package:downgrade/screens/edit_screen.dart';
import 'package:downgrade/widgets/info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/benevole.dart';

class DetailScreen extends StatelessWidget {
  static String routeName = './detail-screen';

  @override
  Widget build(BuildContext context) {

    final String args = ModalRoute.of(context).settings.arguments;

    BenevoleFile _benevole = BenevoleFile(
      id: [],
      name: [],
      number: [],
      email: [],
      adresse: [],
      profession: [],
      availability: []);
    
    // Benevole benevoleSelected

    context.select(
        (BenevoleNotifier controller) => controller.benevole != null? _benevole = controller.benevole : null);
        final indexSelected = _benevole.id.indexWhere((id) => id == args);
      
    // final Benevole benevoleSelected =
    //     benevoleData.firstWhere((element) => element.id == args);

    return Scaffold(
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
                            Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.arrow_back_rounded,),
                          color: Colors.white),
                      IconButton(
                          onPressed: () {
                            // Navigator.of(context).pushNamed(
                            //     EditScreen.routeName,
                            //     arguments: args);
                          },
                          icon: Icon(Icons.edit),
                          color: Colors.white),
                    ],
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        _benevole.name[indexSelected],
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
                      info: _benevole.number[indexSelected],
                    ),
                    Info(
                      title: 'E-mail',
                      info: _benevole.email[indexSelected],
                    ),
                    Info(
                      title: 'Adresse',
                      info: _benevole.adresse[indexSelected],
                    ),
                    Info(
                      title: 'Profession',
                      info: _benevole.profession[indexSelected],
                    ),
                    Info(
                      title: 'Disponibilité',
                      info: _benevole.availability[indexSelected],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.delete_rounded), onPressed: (){
        context.read<BenevoleNotifier>().deleteUser(args, _benevole);
        Navigator.of(context).pop();
      }, splashColor: Colors.red)
    );
  }
}
