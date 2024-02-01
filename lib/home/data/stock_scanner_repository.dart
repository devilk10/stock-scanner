import 'dart:convert';

import 'package:http/http.dart' as http;

import 'scanner_result.dart';

class StockScannerRepository {
  final http.Client client;

  StockScannerRepository({required this.client});

  Future<List<ScannerResult>> fetchData() async {
    final response = await client.get(
      Uri.parse('http://coding-assignment.bombayrunning.com/data.json'),
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      final List<ScannerResult> scannerResults = data.map((item) {
        return ScannerResult.fromJson(item);
      }).toList();

      return scannerResults;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
