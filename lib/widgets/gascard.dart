import 'package:flutter/material.dart';

class GasCard extends StatelessWidget {
  final IconData iconData;
  final String title;
  final Color color;
  final int gwei;

  const GasCard({
    Key? key,
    required this.iconData,
    required this.title,
    required this.color,
    required this.gwei,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Card(
        color: HSLColor.fromColor(color).withLightness(0.9).toColor(),
        shadowColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: color),
        ),
        child: Row(
          children: [
            const SizedBox(width: 28),
            Icon(iconData, size: 64, color: color),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$gwei',
                  style: TextStyle(color: color),
                  textScaleFactor: 4,
                  textAlign: TextAlign.center,
                ),
                Text(
                  title,
                  style: TextStyle(color: color),
                  textScaleFactor: 2,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
