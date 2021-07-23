import 'package:freezed_annotation/freezed_annotation.dart';

import '../services/etherscan/gastracker.dart';

part 'gas_info.freezed.dart';

@freezed
@immutable
class GasInfo with _$GasInfo {
  const factory GasInfo({
    required String lastBlock,
    required int? fast,
    required int? normal,
    required int? slow,
  }) = _GasInfo;

  factory GasInfo.fromOracle(GasOracle oracle) => GasInfo(
        lastBlock: oracle.lastBlock,
        fast: int.parse(oracle.fastPrice),
        normal: int.parse(oracle.proposePrice),
        slow: int.parse(oracle.safePrice),
      );

  static const empty = GasInfo(
    lastBlock: 'Not connected',
    fast: null,
    normal: null,
    slow: null,
  );
}
