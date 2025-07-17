import 'package:flutter/material.dart';
import 'package:my_app_flutter/features/google_map/view/widgets/map_picker.dart';
import 'package:my_app_flutter/features/google_map/view/widgets/search_box.dart';
import 'package:my_app_flutter/features/google_map/viewmodel/map_picker_viewmodel.dart';
import 'package:provider/provider.dart';

class MapPickerPage extends StatelessWidget {
  const MapPickerPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Picker'),
      ),
      body: ChangeNotifierProvider<MapPickerViewModel>(
        create: (BuildContext context) => MapPickerViewModel(),
        child: MapPickerBody(),
      )
    );
  }
}

class MapPickerBody extends StatelessWidget {
  const MapPickerBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MapPickerViewModel>(
      builder: (context, mapPickerViewModel, child) => Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: <Widget>[
                MapPicker(mapPickerViewModel),
                SearchBox(mapPickerViewModel),
              ],
            ),
          ),
          Footer(),
        ],
      ),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    MapPickerViewModel mapPickerViewModel = Provider.of<MapPickerViewModel>(context);
    return Container(
      height: 90,
      width: double.infinity,
      color: Colors.blue[50],
      child: FractionallySizedBox(
        widthFactor: 0.7,
        heightFactor: 0.5,
        child: ElevatedButton(
          onPressed: () {
            debugPrint("lat " + mapPickerViewModel.currentLocation!.lat.toString() + " lng:" + mapPickerViewModel.currentLocation!.lng.toString());
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
          ),
          child: Text(
            "Chọn",
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
          ),
        ),
        
      ),
    );
  }
}