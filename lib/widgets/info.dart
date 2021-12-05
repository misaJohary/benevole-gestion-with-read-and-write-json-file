import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  final String title;
  final String info;

  const Info({
    @required this.title,
    this.info = ' ',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: RichText(
        text: TextSpan(
            text: '$title : ',
            style: Theme.of(context)
                .textTheme
                .caption
                .copyWith(fontStyle: FontStyle.italic, fontSize: 15),
            children: [
              TextSpan(
                text: info,
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: Colors.blueGrey, fontStyle: FontStyle.normal),
              ),
            ]),
      ),
    );
  }
}
