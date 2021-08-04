import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/gas_cubit.dart';

class StatusIndicator extends StatelessWidget {
  const StatusIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: BlocBuilder<GasCubit, GasState>(
        builder: (_, state) {
          return _StatusIndicator(
            status: state.info.lastBlock,
            color: colorGasState(state),
          );
        },
      ),
    );
  }
}

class _StatusIndicator extends StatelessWidget {
  final String status;
  final Color color;

  const _StatusIndicator({
    Key? key,
    required this.status,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(status, style: TextStyle(color: color, fontSize: 16)),
        const SizedBox(width: 12),
        Icon(Icons.circle, color: color, size: 16),
      ],
    );
  }
}

Color colorGasState(GasState state) {
  switch (state.status) {
    case GasStatus.failure:
      return Colors.red;
    case GasStatus.success:
      return Colors.green.shade800;
  }
}
