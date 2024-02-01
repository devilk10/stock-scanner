import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:stock_scanner/home/data/scanner_result.dart';
import 'package:stock_scanner/home/data/stock_scanner_repository.dart';
import 'package:stock_scanner/home/ui/cubit/stock_scanner_cubit.dart';

import 'stock_scanner_cubit_test.mocks.dart';

@GenerateNiceMocks([MockSpec<StockScannerRepository>()])
void main() {
  group('StockScannerCubit', () {
    late StockScannerRepository mockRepository;
    late StockScannerCubit cubit;

    setUp(() {
      mockRepository = MockStockScannerRepository();
      cubit = StockScannerCubit(mockRepository);
    });

    tearDown(() {
      cubit.close();
    });

    blocTest(
      'emits [StockScannerLoading, StockScannerLoaded] on successful fetch',
      build: () {
        final List<ScannerResult> testData = [];
        when(mockRepository.fetchData()).thenAnswer((_) async => testData);
        return cubit;
      },
      act: (cubit) => cubit.fetchData(),
      expect: () => [StockScannerLoading(), StockScannerLoaded(data: [])],
    );

    blocTest(
      'emits [StockScannerLoading, StockScannerError] on failed fetch',
      build: () {
        when(mockRepository.fetchData())
            .thenThrow(Exception('Failed to fetch data'));
        return cubit;
      },
      act: (cubit) => cubit.fetchData(),
      expect: () => [
        StockScannerLoading(),
        StockScannerError(error: 'Failed to fetch data')
      ],
    );
  });
}
