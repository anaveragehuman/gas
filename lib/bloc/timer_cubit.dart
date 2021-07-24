import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

/// Produces a [Stream] that counts down from [ticks] once every second.
Stream<void> ticker({required int ticks}) =>
    Stream<void>.periodic(const Duration(seconds: 1)).take(ticks);

class TimerCubit extends Cubit<int> {
  final int initial;
  static const int doneWhen = 0;
  StreamSubscription<void>? _tickerSubscription;

  /// Create a [TimerCubit] that counts down [initial] seconds.
  TimerCubit(this.initial) : super(initial);

  @override
  Future<void> close() {
    stop();
    return super.close();
  }

  /// Start ticking down from the current state.
  void start() => _tickerSubscription = ticker(ticks: state).listen(_tick);

  /// Stop ticking down, but don't reset the state.
  void stop() => _tickerSubscription?.cancel();

  /// Restore the timer to the [initial] state.
  void reset() => emit(initial);

  /// Immediately restore the timer to the [initial] state and continue ticking.
  void restart() {
    stop();
    reset();
    start();
  }

  void _tick(void _) => emit(state - 1);
}
