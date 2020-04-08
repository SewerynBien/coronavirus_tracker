import 'package:coronavirus_tracker/models/country.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CountryWindow extends StatelessWidget {
  final Country country;
  final double FONT_SIZE = 16;

  CountryWindow(this.country);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black87,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
              child: Text(
                country.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: FONT_SIZE + 5,
                  fontFamily: 'Kameron',
                ),
              ),
            ),
            buildColumnElement(
                MdiIcons.human, 'Cases: ', country.cases, Colors.blue[700]),
            buildColumnElement(MdiIcons.plus, 'Today Cases: ',
                country.todayCases, Colors.blue[300]),
            buildColumnElement(
                MdiIcons.skull, 'Deaths: ', country.deaths, Colors.red[600]),
            buildColumnElement(MdiIcons.skullOutline, 'Today Deaths: ',
                country.todayDeaths, Colors.red[300]),
            buildColumnElement(MdiIcons.hospital, 'Recovered: ',
                country.recovered, Colors.green),
            buildColumnElement(MdiIcons.accountAlert, 'Critical: ',
                country.critical, Colors.orange[700]),
            Visibility(
              visible: (country.casesPerOneMillion.toInt() != -1),
              child: buildColumnElement(
                  MdiIcons.accountGroup,
                  'Cases Per One Million: ',
                  (country.casesPerOneMillion * 100).toInt(),
                  Colors.lime),
            ),
            Visibility(
              visible: (country.deathsPerOneMillion.toInt() != -1),
              child: buildColumnElement(
                  MdiIcons.skullOutline,
                  'Deaths Per One Million: ',
                  (country.deathsPerOneMillion * 100).toInt(),
                  Colors.red[900]),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildColumnElement(
      IconData icon, String title, int info, Color color) {
    String text = title + '----';
    if (info != -1) text = title + info.toString();

    if (title == 'Cases Per One Million: ' ||
        title == 'Deaths Per One Million: ')
      text = title + (info / 100).toString();

    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 6.0, 0.0),
          child: new Icon(
            icon,
            color: color,
          ),
        ),
        new Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: FONT_SIZE,
            //fontFamily: 'Kameron',
          ),
        ),
      ],
    );
  }
}
