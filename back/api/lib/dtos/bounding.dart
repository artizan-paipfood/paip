class Bounding {
  final double latMin;
  final double latMax;
  final double lonMin;
  final double lonMax;

  Bounding({required this.latMin, required this.latMax, required this.lonMin, required this.lonMax});

  String get bounds => '$latMin,$lonMin,$latMax,$lonMax';
}
