import 'dart:convert';

import 'package:gastracker/services/etherscan/gastracker.dart';
import 'package:test/test.dart';

void main() {
  const sampleJson =
      '''{"LastBlock":"12879723","SafeGasPrice":"12","ProposeGasPrice":"14","FastGasPrice":"18"}''';

  final oracle =
      GasOracle.fromJson(jsonDecode(sampleJson) as Map<String, dynamic>);

  test('GasOracle properly deserializes', () {
    expect(oracle, isA<GasOracle>());
    expect(oracle.lastBlock, equals('12879723'));
    expect(oracle.safePrice, equals('12'));
    expect(oracle.proposePrice, equals('14'));
    expect(oracle.fastPrice, equals('18'));
  });
}
