import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:state_managements_in_life/feature/maps/service/map_service.dart';
import 'package:state_managements_in_life/feature/maps/viewmodel/map_view_model.dart';
import 'package:state_managements_in_life/product/constant/product_constant.dart';
import 'package:state_managements_in_life/product/init/network/network_product.dart';
import 'package:state_managements_in_life/product/utility/extensions/map_model_markers.dart';

class MapSelectView extends StatefulWidget {
  const MapSelectView({Key? key}) : super(key: key);

  @override
  State<MapSelectView> createState() => _MapSelectViewState();
}

class _MapSelectViewState extends State<MapSelectView> {
  late final MapViewModel _mapViewModel;
  final double _cardSize = 200;

  GoogleMapController? _controller;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _mapViewModel = MapViewModel(MapService(NetworkProduct.instance.networkManager));
    _mapViewModel.fetchAllMaps();
  }

  //this is the function to load custom map style json
  void changeMapMode(GoogleMapController? mapController) {
    getJsonFile("assets/map_style.json").then((value) => setMapStyle(value, mapController!));
  }

  //helper function
  void setMapStyle(String mapStyle, GoogleMapController mapController) {
    mapController.setMapStyle(mapStyle);
  }

  //helper function
  Future<String> getJsonFile(String path) async {
    ByteData byte = await rootBundle.load(path);
    var list = byte.buffer.asUint8List(byte.offsetInBytes, byte.lengthInBytes);
    return utf8.decode(list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _googleMaps(),
          Positioned(height: _cardSize, left: 0, right: 0, bottom: kToolbarHeight, child: _pageViewAnimals())
        ],
      ),
    );
  }

  Observer _pageViewAnimals() {
    return Observer(builder: (_) {
      return PageView.builder(
        onPageChanged: (value) {
          _mapViewModel.changeIndex(value);
          _controller?.animateCamera(CameraUpdate.newLatLng(_mapViewModel.mapModelItems[value].latlong));
        },
        itemCount: _mapViewModel.mapModelItems.length,
        controller: PageController(viewportFraction: 0.8),
        itemBuilder: (context, index) {
          return Card(child: Image.network(_mapViewModel.mapModelItems[index].detail?.photoUrl ?? ''));
        },
      );
    });
  }

  Observer _googleMaps() {
    return Observer(builder: (_) {
      return _mapViewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _mapViewModel.mapModelItems.first.latlong,
                zoom: 5,
              ),
              onMapCreated: (controller) {
                _controller = controller;
                changeMapMode(_controller);
              },
              markers: _mapViewModel.mapModelItems.toMarkers(_mapViewModel.selectedIndex),
            );
    });
  }
}
