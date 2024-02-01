import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:stock_scanner/home/data/scanner_result.dart';
import 'package:stock_scanner/home/data/stock_scanner_repository.dart';

import 'stock_scanner_repository_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Client>()])
void main() {
  group('StockScannerRepository', () {
    late StockScannerRepository repository;
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
      repository = StockScannerRepository(client: mockClient);
    });

    test(
        'fetchData returns a list of ScannerResult if the http call completes successfully',
        () async {
      const responseData =
          '[{"id": 1, "name": "Test Scanner", "tag": "Tag", "color": "green", "criteria": []}]';
      final expectedResults = [
        const ScannerResult(
            id: 1,
            name: 'Test Scanner',
            tag: 'Tag',
            color: 'green',
            criteria: []),
      ];

      when(mockClient.get(Uri.parse(
              'http://coding-assignment.bombayrunning.com/data.json')))
          .thenAnswer((_) async => http.Response(responseData, 200));

      final results = await repository.fetchData();

      expect(results, expectedResults);
    });

    test(
        'fetchData throws an exception if the http call completes with an error',
        () async {
      when(mockClient.get(Uri.parse(
              'http://coding-assignment.bombayrunning.com/data.json')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(() => repository.fetchData(), throwsException);
    });
  });
}
