import '../services/etherscan/gastracker.dart';

class GasInfo {
  final String lastBlock;
  final int? fast;
  final int? normal;
  final int? slow;

  const GasInfo({
    required this.lastBlock,
    required this.fast,
    required this.normal,
    required this.slow,
  });

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
