import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_app_flutter/features/base_page.dart';
import 'package:my_app_flutter/features/google_map/model/location_model.dart';
import 'package:my_app_flutter/features/google_map/viewmodel/map_picker_viewmodel.dart';
class MapPicker extends BasePage {
  final MapPickerViewModel mapPickerViewModel;
  const MapPicker(this.mapPickerViewModel, {super.key});
  @override
  State<MapPicker> createState() => _MapPickerState();
}
class _MapPickerState  extends BaseState<MapPicker> {
  final Completer<GoogleMapController> _controller = Completer();
  final LatLng _target = LatLng(
    10.85636,
    106.6543,
  );

  @override
  void initState() {
    super.initState();
    widget.mapPickerViewModel.locationController.stream.listen(
      (location) async {
        GoogleMapController mapController = await _controller.future;
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(
                location.lat!,
                location.lng!,
              ),
              zoom: 15.0,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GoogleMap(
          mapType: MapType.normal,
          //myLocationEnabled: true,
          myLocationButtonEnabled: false,
          initialCameraPosition: CameraPosition(
            target: _target,
            zoom: 15,
          ),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          onCameraMove: (CameraPosition newPosition) async {
            widget.mapPickerViewModel.setLocationByMovingMap(LocationModel(
              lat: newPosition.target.latitude,
              lng: newPosition.target.longitude,
            ));
          },
        ),
        Center(
          child: Icon(
            Icons.location_on,
            color: Colors.red,
            size: 36,
          ),
        ),
      ],
    );
  }
}