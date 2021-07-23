import 'package:bloc/bloc.dart';

import '../repositories/gas_info.dart';
import '../services/etherscan/gastracker.dart';

enum GasStatus { success, failure }

class GasState {
  final GasStatus status;
  final bool isLoading;
  final GasInfo info;

  const GasState({
    required this.status,
    this.isLoading = false,
    this.info = GasInfo.empty,
  });
}

class GasCubit extends Cubit<GasState> {
  GasCubit() : super(const GasState(status: GasStatus.failure));

  Future<void> fetchGas() async {
    emit(const GasState(status: GasStatus.success, isLoading: true));

    try {
      final oracle = await getGasInfo();
      final info = GasInfo.fromOracle(oracle);
      emit(GasState(status: GasStatus.success, info: info));
    } on Exception {
      emit(const GasState(status: GasStatus.failure));
    }
  }
}
