class Country {
  final String name;
  final double latitude, longitude, casesPerOneMillion, deathsPerOneMillion;
  final int cases, todayCases, deaths, todayDeaths, recovered, active, critical;

  Country(
      {this.name,
      this.latitude,
      this.longitude,
      this.casesPerOneMillion,
      this.deathsPerOneMillion,
      this.cases,
      this.todayCases,
      this.deaths,
      this.todayDeaths,
      this.recovered,
      this.active,
      this.critical});
}
