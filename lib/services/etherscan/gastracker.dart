import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

part 'gastracker.g.dart';

const String _etherscanApiUri = 'api.etherscan.io';
const String _module = 'gastracker';
const String _apiKey = 'YourAPIKeyToken';

@JsonSerializable(fieldRename: FieldRename.pascal)
class GasOracle {
  final String lastBlock;
  @JsonKey(name: 'SafeGasPrice')
  final String safePrice;
  @JsonKey(name: 'ProposeGasPrice')
  final String proposePrice;
  @JsonKey(name: 'FastGasPrice')
  final String fastPrice;

  const GasOracle({
    required this.lastBlock,
    required this.safePrice,
    required this.proposePrice,
    required this.fastPrice,
  });

  factory GasOracle.fromJson(Map<String, dynamic> json) =>
      _$GasOracleFromJson(json);
}

Future<GasOracle> getGasInfo({String? apiKey}) async {
  const _action = 'gasoracle';
  final uri = Uri.https(_etherscanApiUri, '/api', <String, String>{
    'module': _module,
    'action': _action,
    'apikey': apiKey ?? _apiKey,
  });

  final response = await http.get(uri);
  final decoded = jsonDecode(response.body) as Map<String, dynamic>;
  return GasOracle.fromJson(decoded['result'] as Map<String, dynamic>);
}
