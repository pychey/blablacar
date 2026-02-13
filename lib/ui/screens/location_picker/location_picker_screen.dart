import 'package:blabla/dummy_data/dummy_data.dart';
import 'package:blabla/model/ride/locations.dart';
import 'package:blabla/services/ride_prefs_service.dart';
import 'package:blabla/ui/screens/location_picker/widgets/location_tile.dart';
import 'package:blabla/ui/theme/theme.dart';
import 'package:flutter/material.dart';

class LocationPickerScreen extends StatefulWidget {
  final Location? selectedLocation;
  const LocationPickerScreen({super.key, required this.selectedLocation});

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  String search = '';
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();

    search = widget.selectedLocation?.name ?? '';
    _searchController = TextEditingController(text: search);
  }

  void handleClear () {
    setState(() {
      search = '';
      _searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredLocations = fakeLocations
      .where((location) =>
        location.name.toLowerCase().contains(search.toLowerCase()) ||
        location.country.name.toLowerCase().contains(search.toLowerCase()),
      ).toList();

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: BlaSpacings.m, horizontal: BlaSpacings.l),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                filled: true,
                fillColor: BlaColors.disabled,
                hintText: 'Station Road or The Bridge Cafe',
                hintStyle: BlaTextStyles.body.copyWith(color: BlaColors.textLight),
                prefixIcon: IconButton(
                  onPressed: () => Navigator.pop<Location>(context),
                  icon: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: BlaColors.iconLight,
                    size: 20,
                  ),
                ),
                suffixIcon: search.isEmpty
                    ? null
                    : IconButton(
                        onPressed: handleClear,
                        icon: Icon(
                          Icons.clear,
                          color: BlaColors.iconLight,
                          size: 24,
                        ),
                      ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(BlaSpacings.radius),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  search = value;
                });
              },
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: search == '' ? RidePrefService.ridePrefsHistory.length : filteredLocations.length,
              itemBuilder: (context, index) {
                final location = search == '' ? RidePrefService.ridePrefsHistory[index].departure : filteredLocations[index];
                return LocationTile(location: location);
              },
            ),
          ),
        ],
      ),
    );
  }
}
