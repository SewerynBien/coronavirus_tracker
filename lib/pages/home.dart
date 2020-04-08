import 'package:coronavirus_tracker/widgets/country_window.dart';
import 'package:coronavirus_tracker/widgets/error_screen.dart';
import 'package:coronavirus_tracker/widgets/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:coronavirus_tracker/managers/network_manager.dart';
import 'package:coronavirus_tracker/models/country.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final double ZOOM = 5.0;
  List<Marker> markers = new List();
  Country currentCountry, total;
  int status = 1; //0 - success, 1 - loading, 2 - error

  @override
  void initState() {
    super.initState();

    loadHome();
  }

  @override
  Widget build(BuildContext context) {
    if (status == 1)
      return new LoadingScreen();
    else
      return Stack(
        children: <Widget>[
          (status == 2)
              ? (new ErrorScreen()
                  /* Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black87,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.error,
                            size: 60,
                            color: Colors.red[600],
                          )),
                      Text(
                        'There was an error with your network connection! Reconnect and press the refresh button.',
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.red[600],
                            fontFamily: 'OpenSans Light'),
                      ),
                    ],
                  )) */
                  )
              : (new FlutterMap(
                  options: new MapOptions(
                    center: new LatLng(51.5, -0.09),
                    zoom: ZOOM,
                    onTap: (point) {
                      if (status == 0 && currentCountry != total)
                        setState(() {
                          this.currentCountry = total;
                        });
                    },
                  ),
                  layers: [
                    TileLayerOptions(
                      urlTemplate:
                          'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: ['a', 'b', 'c'],
                    ),
                    new MarkerLayerOptions(
                      markers: markers,
                    ),
                    /* new PolylineLayerOptions(polylines: polylines), */
                  ],
                )),
          Visibility(
            visible: (currentCountry != null),
            child: Positioned(
              top: 15,
              left: 20,
              child: CountryWindow(this.currentCountry),
            ),
          ),
          /* Visibility(
            visible: (status != 1),
            child:  */
          Positioned(
            bottom: 15,
            right: 20,
            child: Container(
                width: 80.0,
                height: 80.0,
                child: FloatingActionButton(
                  child: Icon(
                    Icons.refresh,
                    color: Colors.red[700],
                    size: 45.0,
                  ),
                  shape: CircleBorder(
                      side: BorderSide(color: Colors.red[700], width: 3.0)),
                  backgroundColor: Colors.black87,
                  onPressed: () {
                    setState(() {
                      status = 1;
                    });
                    loadHome();
                  },
                )),
          ),
          /* ), */
        ],
      );
  }

  void loadHome() async {
    NetworkManager networkManager = new NetworkManager();
    List<Country> countries = await networkManager.fetchCountries();
    List<Marker> markers;
    Country total;

    if (countries != null) {
      markers = await fetchMarkers(countries);
      total = await fetchTotal(countries);
    }

    if (markers != null)
      setState(() {
        this.markers = markers;
        this.total = total;
        this.currentCountry = total;
        status = 0;
      });
    else {
      setState(() {
        status = 2;
      });
    }
  }

  Future<List<Marker>> fetchMarkers(List<Country> countries) async {
    return buildMarkers(countries);
  }

  List<Marker> buildMarkers(List<Country> countries) {
    List<Marker> markers = new List();
    for (Country country in countries) markers.add(buildMarker(country));
    return markers;
  }

  Marker buildMarker(Country country) {
    final double SIZE = 40;

    return new Marker(
      width: SIZE,
      height: SIZE,
      point: new LatLng(country.latitude, country.longitude),
      builder: (context) => new FloatingActionButton(
        child: Icon(
          MdiIcons.informationVariant,
          color: Colors.red[700],
        ),
        shape:
            CircleBorder(side: BorderSide(color: Colors.red[700], width: 2.5)),
        backgroundColor: Colors.black87,
        onPressed: () {
          setState(() {
            this.currentCountry = country;
          });
        },
      ),
    );
  }

  Future<Country> fetchTotal(List<Country> countries) async {
    return new Country(
        name: 'Total',
        latitude: 0,
        longitude: 0,
        casesPerOneMillion: -1,
        deathsPerOneMillion: -1,
        cases: countSumInCountries(countries, 0),
        todayCases: countSumInCountries(countries, 1),
        deaths: countSumInCountries(countries, 2),
        todayDeaths: countSumInCountries(countries, 3),
        recovered: countSumInCountries(countries, 4),
        active: countSumInCountries(countries, 5),
        critical: countSumInCountries(countries, 6));
  }

  int countSumInCountries(List<Country> countries, int status) {
    int sum = 0;
    for (Country country in countries)
      if (status == 0)
        sum += country.cases;
      else if (status == 1)
        sum += country.todayCases;
      else if (status == 2)
        sum += country.deaths;
      else if (status == 3)
        sum += country.todayDeaths;
      else if (status == 4)
        sum += country.recovered;
      else if (status == 5)
        sum += country.active;
      else if (status == 6) sum += country.critical;

    return sum;
  }
}
