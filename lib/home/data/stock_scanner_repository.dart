import 'dart:convert';

import 'package:http/http.dart' as http;

import 'scanner_result.dart';

class StockScannerRepository {
  Future<List<ScannerResult>> fetchData() async {
    final response = await http
        .get(Uri.parse('http://coding-assignment.bombayrunning.com/data.json'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<ScannerResult> scannerResults = data.map((item) {
        return ScannerResult.fromJson(item);
      }).toList();

      return scannerResults;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
