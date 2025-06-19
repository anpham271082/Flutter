import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:my_app_flutter/features/google_map/model/location_model.dart';
import 'package:my_app_flutter/features/google_map/viewmodel/map_picker_viewmodel.dart';

class SearchBox extends StatefulWidget {
  final MapPickerViewModel mapPickerViewModel;
  const SearchBox(this.mapPickerViewModel, {super.key});
  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: TypeAheadField(
        builder: (context, controller, focusNode) {
          return TextField(
            controller: controller,
            focusNode: focusNode,
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              labelText: 'Tìm kiếm',
            ),
          );
        },
        suggestionsCallback: (pattern) async {
          return await widget.mapPickerViewModel.search(pattern);
        },
        itemBuilder: (BuildContext context, LocationModel location) {
          return ListTile(
            leading: Icon(
              Icons.location_on,
              color: Colors.redAccent,
            ),
            title: Container(
              margin: EdgeInsets.only(bottom: 7),
              child: Text(
                location.name!,
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                ),
              ),
            ),
            subtitle: Text(location.formattedAddress!),
          );
        },
        onSelected: (LocationModel location) {
          widget.mapPickerViewModel.locationSelected(location);
        },
      ),
    );
  }
}