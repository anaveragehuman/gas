import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'pref_cubit.dart';

/// Produces a [Stream] that counts down from [ticks] once every second.
Stream<void> ticker({required int ticks}) =>
    Stream<void>.periodic(const Duration(seconds: 1)).take(ticks);

class TimerCubit extends Cubit<int> with WidgetsBindingObserver {
  final PrefCubit prefs;
  late final StreamSubscription<PrefState> _prefSubscription;

  int get initial => prefs.state.refreshRate;
  static const int doneWhen = 0;
  StreamSubscription<void>? _tickerSubscription;

  /// Create a [TimerCubit] that counts down `refreshRate` seconds from [prefs].
  TimerCubit(this.prefs) : super(prefs.state.refreshRate) {
    WidgetsBinding.instance!.addObserver(this);
    _prefSubscription = prefs.stream.listen((_) => restart());
  }

  @override
  Future<void> close() {
    stop();
    WidgetsBinding.instance!.removeObserver(this);
    _prefSubscription.cancel();
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

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        start();
        break;
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
        stop();
        break;
    }
  }
}
