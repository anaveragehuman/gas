import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/gas_cubit.dart';
import '../repositories/gas_info.dart';

class GasCard extends StatelessWidget {
  final IconData iconData;
  final String title;
  final Color color;
  final int? Function(GasInfo) gwei;

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
                BlocBuilder<GasCubit, GasState>(
                  buildWhen: (prev, curr) => gwei(curr.info) != gwei(prev.info),
                  builder: (_, state) => _GasText(
                    gwei(state.info)?.toString() ?? '--',
                    color: color,
                    scale: 4,
                  ),
                ),
                _GasText(title, color: color, scale: 2),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class _GasText extends StatelessWidget {
  final String text;
  final Color color;
  final double scale;

  const _GasText(
    this.text, {
    Key? key,
    required this.color,
    this.scale = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: color),
      textScaleFactor: scale,
      textAlign: TextAlign.center,
    );
  }
}
