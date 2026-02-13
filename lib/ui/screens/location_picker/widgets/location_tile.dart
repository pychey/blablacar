import 'package:blabla/model/ride/locations.dart';
import 'package:blabla/services/ride_prefs_service.dart';
import 'package:blabla/ui/theme/theme.dart';
import 'package:blabla/ui/widgets/display/bla_divider.dart';
import 'package:flutter/material.dart';

class LocationTile extends StatelessWidget {
  final Location location;

  const LocationTile({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return (Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          leading: RidePrefService.ridePrefsHistory.any((ride) => ride.departure == location || ride.arrival == location) ? Icon(Icons.history, color: BlaColors.iconLight) : null,
          title: Text(location.name, style: BlaTextStyles.body.copyWith(color: BlaColors.textNormal)),
          subtitle: Text(location.country.name, style: BlaTextStyles.label.copyWith(color: BlaColors.textLight)),
          trailing: Icon(
            Icons.keyboard_arrow_right_outlined,
            color: BlaColors.iconLight,
          ),
          onTap: () {
            Navigator.pop<Location>(context, location);
          },
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: BlaDivider(),
        ),
      ],
    ));
  }
}
