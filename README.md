# CoronaTracker
## _Stay Informed, Stay Safe_

[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)

CoronaTracker is a mobile application that tracks the progress of the COVID-19 pandemic. This app will work on both Android and iOS phones.

## Features
- Show informations about the COVID-19 pandemic:
-- near the user's location,
-- in the chosen country,
-- around the World.
- Refresh informations about the COVID-19 pandemic every day
- Display informations about the COVID-19 pandemic (in a transparent way) on a map


## Tech
**Flutter**, **Dart** (also a bit of **Java** and **Swift**) were used to create the project.
In addition, the following Dart packages were used:
- [**cupertino_icons**] - default icons asset for Cupertino widgets,
- [**latlong**] - very useful for latitude and longitude calculation,
- [**http**] - very cool API for handling HTTP requests,
- [**flutter_map**] - useful for displaying various maps inside mobile app,
- [**material_design_icons_flutter**] - beautiful material design icons,
- [**flutter_spinkit**] - very cool loading animations.

Big thanks to **disease-sh** for sharing their API with fresh informations about the COVID-19 pandemic.
https://github.com/disease-sh/API


## Launching
Anyone can install and test this application on their own.
Just plug in your mobile device, make sure that You are in the **corona_tracker** folder, then run:
```sh
flutter run
```


## License
MIT
