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
            isLoading: state.isLoading,
          );
        },
      ),
    );
  }
}

class _StatusIndicator extends StatelessWidget {
  final String status;
  final Color color;
  final bool isLoading;

  const _StatusIndicator({
    Key? key,
    required this.status,
    required this.color,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(status, style: TextStyle(color: color, fontSize: 16)),
        const SizedBox(width: 12),
        SizedBox(
          width: 20,
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Icon(Icons.circle, color: color, size: 16),
              if (isLoading) Spinner(color: color, size: 20),
            ],
          ),
        ),
      ],
    );
  }
}

class Spinner extends StatefulWidget {
  final Color color;
  final double size;

  const Spinner({
    Key? key,
    required this.color,
    required this.size,
  }) : super(key: key);

  @override
  State<Spinner> createState() => _SpinnerState();
}

class _SpinnerState extends State<Spinner> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutQuart,
      ),
      child: CustomPaint(
        size: Size.square(widget.size),
        painter: _ArcPainter(color: widget.color),
      ),
    );
  }
}

class _ArcPainter extends CustomPainter {
  final Color color;

  const _ArcPainter({
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.longestSide / 10;

    canvas.drawArc(Offset.zero & size, 0, 2, false, paint);
  }

  @override
  bool shouldRepaint(_ArcPainter oldDelegate) => oldDelegate.color != color;
}

Color colorGasState(GasState state) {
  switch (state.status) {
    case GasStatus.failure:
      return Colors.red;
    case GasStatus.success:
      return Colors.green.shade800;
  }
}
