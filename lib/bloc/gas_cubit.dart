import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../repositories/gas_info.dart';
import '../services/etherscan/gastracker.dart';
import 'timer_cubit.dart';

part 'gas_cubit.freezed.dart';

enum GasStatus { success, failure }

@freezed
@immutable
class GasState with _$GasState {
  const factory GasState({
    required GasStatus status,
    @Default(false) bool isLoading,
    @Default(GasInfo.empty) GasInfo info,
  }) = _GasState;
}

class GasCubit extends Cubit<GasState> {
  final TimerCubit timer;
  late final StreamSubscription timerSubscription;

  Future<void> onTimerChanged(int state) async {
    if (state == TimerCubit.doneWhen && !this.state.isLoading) {
      try {
        await fetchGas();
      } finally {
        timer.restart();
      }
    }
  }

  GasCubit(this.timer) : super(const GasState(status: GasStatus.failure)) {
    fetchGas().whenComplete(() {
      timer.start();
      timerSubscription = timer.stream.listen(onTimerChanged);
    });
  }

  @override
  Future<void> close() {
    timerSubscription.cancel();
    timer.stop();
    return super.close();
  }

  Future<void> fetchGas() async {
    emit(state.copyWith(isLoading: true));

    try {
      final oracle = await getGasInfo();
      final info = GasInfo.fromOracle(oracle);
      emit(GasState(status: GasStatus.success, info: info));
    } catch (_) {
      emit(state.copyWith(status: GasStatus.failure, isLoading: false));
    }
  }
}
