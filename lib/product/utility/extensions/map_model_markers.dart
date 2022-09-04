import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:state_managements_in_life/feature/maps/model/map_model.dart';

extension MapMarkersExtensions on List<MapModel> {
  Set<Marker> toMarkers(int selectedIndex) {
    return Set.of(
      map(
        (e) => Marker(
            markerId: MarkerId('${e.lat}'),
            position: e.latlong,
            icon: BitmapDescriptor.defaultMarkerWithHue(
                this[selectedIndex] == e ? BitmapDescriptor.hueAzure : BitmapDescriptor.hueOrange)),
      ),
    );
  }
}
