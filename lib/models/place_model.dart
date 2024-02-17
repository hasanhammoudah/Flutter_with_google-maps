import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  final int id;
  final String name;
  final LatLng latLng;

  PlaceModel({required this.id, required this.name, required this.latLng});
}

List<PlaceModel> places = [
  PlaceModel(
    id: 1,
    name: 'None',
    latLng: const LatLng(31.943415, 35.890244),
  ),
  PlaceModel(
    id: 2,
    name: 'None2',
    latLng: const LatLng(31.951223, 35.884667),
  ),
  PlaceModel(
    id: 3,
    name: 'None3',
    latLng: const LatLng(31.902467, 35.853992

),
  ),
];
