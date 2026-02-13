import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class BlaButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isPrimary;
  final IconData? icon;

  const BlaButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isPrimary = true,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? BlaColors.primary : BlaColors.white,
        foregroundColor: isPrimary ? BlaColors.white : BlaColors.primary,
        elevation: 0,
        side: isPrimary ? null : BorderSide(color: BlaColors.iconLight),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BlaSpacings.radiusLarge),
        ),
        padding: EdgeInsets.all(BlaSpacings.l),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: BlaSpacings.s,
        children: [
          if (icon != null) Icon(icon, size: 20),
          Text(label, style: BlaTextStyles.button),
        ],
      ),
    );
  }
}