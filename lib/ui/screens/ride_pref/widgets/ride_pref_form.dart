import 'package:blabla/ui/widgets/display/bla_divider.dart';
import 'package:flutter/material.dart';
 
import '../../../../model/ride/locations.dart';
import '../../../../model/ride_pref/ride_pref.dart';
import '../../../theme/theme.dart';
import 'package:blabla/utils/date_time_util.dart';
import 'package:blabla/ui/widgets/actions/bla_button.dart';
 
///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;



  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    
    if (widget.initRidePref != null) {
      departure = widget.initRidePref!.departure;
      departureDate = widget.initRidePref!.departureDate;
      arrival = widget.initRidePref!.arrival;
      requestedSeats = widget.initRidePref!.requestedSeats;
    } else {
      departure = null;
      departureDate = DateTime.now();
      arrival = null;
      requestedSeats = 1;
    }
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------
 
  void _onSwitchLocations() {
    setState(() {
      final temp = departure;
      departure = arrival;
      arrival = temp;
    });
  }

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------
  
  String get _departureLabelText => departure?.name ?? 'Leaving from';
  String get _arrivalLabelText => arrival?.name ?? 'Going to';

  Color get _departureTextColor => departure != null ? BlaColors.textNormal : BlaColors.textLight;
  Color get _arrivalTextColor => arrival != null ? BlaColors.textNormal : BlaColors.textLight;

  String get _dateLabelText => DateTimeUtils.formatDateTime(departureDate);
  String get _seatsLabelText => '$requestedSeats';

  bool get _canShowSwitchButton => departure != null || arrival != null;

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  
  Widget _buildInputField({
    required IconData icon,
    required VoidCallback onPressed,
    required String label,
    required Color textColor,
    Widget? trailing,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(vertical: BlaSpacings.m),
        child: Row(
          children: [
            Icon(icon, color: BlaColors.iconNormal),
            SizedBox(width: BlaSpacings.s),
            Expanded(child: Text(label, style: BlaTextStyles.body.copyWith(color: textColor))),
            ?trailing,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: BlaSpacings.l),
          decoration: BoxDecoration(
            border: Border.symmetric(vertical: BorderSide(color: BlaColors.greyLight))
          ),
          child: Column(
            children: [
              _buildInputField(
                icon: Icons.trip_origin,
                onPressed: () {},
                label: _departureLabelText,
                textColor: _departureTextColor,
                trailing: _canShowSwitchButton
                    ? IconButton(
                        icon: Icon(Icons.swap_vert, color: BlaColors.primary),
                        onPressed: _onSwitchLocations,
                      )
                    : null,
              ),
              
              BlaDivider(),
              
              _buildInputField(
                icon: Icons.trip_origin,
                onPressed: () {},
                label: _arrivalLabelText,
                textColor: _arrivalTextColor,
              ),
              
              BlaDivider(),
              
              _buildInputField(
                icon: Icons.calendar_month,
                onPressed: () {},
                label: _dateLabelText,
                textColor: BlaColors.textNormal,
              ),
              
              BlaDivider(),
              
              _buildInputField(
                icon: Icons.person_outline,
                onPressed: () {},
                label: _seatsLabelText,
                textColor: BlaColors.textNormal,
              ),
            ],
          ),
        ),
        
        BlaButton(
          label: 'Search',
          onPressed: () {},
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(BlaSpacings.radius), bottomRight: Radius.circular(BlaSpacings.radius)),
        ),
      ],
    );
  }
}