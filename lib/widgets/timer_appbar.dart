import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/timer_cubit.dart';

class TimerProgressBar extends StatelessWidget {
  const TimerProgressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerCubit, int>(
      builder: (context, state) {
        return LinearProgressIndicator(
          color: Colors.deepPurple,
          value: state.toDouble() / context.read<TimerCubit>().initial,
        );
      },
    );
  }
}
