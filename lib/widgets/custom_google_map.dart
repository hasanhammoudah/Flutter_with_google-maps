import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps/models/place_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPosition;
  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
      zoom: 12,
      target: LatLng(
        31.990309,
        35.989721,
      ),
    );
    initMarkers();
    super.initState();
  }

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  late GoogleMapController googleMapController;
  Set<Marker> markers = {};
  @override
  Widget build(BuildContext context) {
    // TODO Part two
    return GoogleMap(
      zoomControlsEnabled: false,
      markers: markers,
      onMapCreated: (controller) {
        googleMapController = controller;
        initMapStyle();
      },
      initialCameraPosition: initialCameraPosition,
    );

    // TODO Part one
    // return Stack(
    //   children: [
    //     GoogleMap(
    //       // mapType: MapType.hybrid,
    //       onMapCreated: (controller) {
    //         googleMapController = controller;
    //       },
    //       // cameraTargetBounds: CameraTargetBounds(
    //       //   LatLngBounds(
    //       //     southwest: const LatLng(
    //       //       31.90181360498022,
    //       //       35.75530758502474,
    //       //     ),
    //       //     northeast: const LatLng(
    //       //       32.02430877589448,
    //       //       35.93653593873442,
    //       //     ),
    //       //   ),
    //       // ),
    //       initialCameraPosition: initialCameraPosition,
    //     ),
    //     Positioned(
    //       bottom: 16,
    //       left: 16,
    //       right: 16,
    //       child: ElevatedButton(
    //         onPressed: () {
    //           CameraPosition cameraPosition = const CameraPosition(
    //             target: LatLng(
    //               31.945781065975474,
    //               35.96776879013519,
    //             ),
    //             zoom: 12,
    //           );
    //           googleMapController.animateCamera(
    //               CameraUpdate.newCameraPosition(cameraPosition));
    //         },
    //         child: const Text(
    //           'Change location',
    //         ),
    //       ),
    //     )
    //   ],
    // );
  }

  // This method for change map style
  void initMapStyle() async {
    var nightMapStyle = await DefaultAssetBundle.of(context)
        .loadString('assets/map_styles/night_map_style.json');
    googleMapController.setMapStyle(nightMapStyle);
  }

  // To control the size of markers
  Future<Uint8List> getImageFromRawData(String image, double width) async {
    var imageData = await rootBundle.load(image);
    var imageCodec = await ui.instantiateImageCodec(
        imageData.buffer.asUint8List(),
        targetWidth: width.round());
    var imageFrame = await imageCodec.getNextFrame();
    var imageBytData =
        await imageFrame.image.toByteData(format: ui.ImageByteFormat.png);
    return imageBytData!.buffer.asUint8List();
  }

// This method for show markers the maps
  void initMarkers() async {
    var customMarkerIcon = BitmapDescriptor.fromBytes(
      await getImageFromRawData(
        'assets/images/marker.png',
        100,
      ),
    );
    // TODO or use the another way is convert resize image from any website online
    //   var customMarkerIcon = await BitmapDescriptor.fromAssetImage(
    //  ImageConfiguration(),'assets/images/marker.png');

    var myMarkers = places
        .map(
          (placeModel) => Marker(
            icon: customMarkerIcon,
            // infoWindow: InfoWindow(
            //   title: placeModel.name,
            // ),
            position: placeModel.latLng,
            markerId: MarkerId(
              placeModel.id.toString(),
            ),
          ),
        )
        .toSet();
    markers.addAll(myMarkers);
    setState(() {});
  }
}

// world view 0 -> 3
// country view 4 -> 6
// city view 10 -> 12
// street view 13 -> 17
// building view 18 -> 20
