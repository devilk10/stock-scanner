import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:stock_scanner/home/data/scanner_result.dart';
import 'package:stock_scanner/home/ui/cubit/stock_scanner_cubit.dart';
import 'package:stock_scanner/home/ui/pages/stock_scanner_page.dart';
import 'package:stock_scanner/home/ui/widgets/variable_text_widget.dart';

import 'stock_scanner_page_test.mocks.dart';

@GenerateNiceMocks([MockSpec<StockScannerCubit>()])
void main() {
  group('StockScannerPage', () {
    late MockStockScannerCubit mockCubit;

    setUp(() {
      mockCubit = MockStockScannerCubit();
    });

    testWidgets('renders loading indicator when StockScannerLoading',
        (tester) async {
      when(mockCubit.state).thenReturn(StockScannerLoading());

      await tester.pumpWidget(
        MaterialApp(
          home: StockScannerPage(mockCubit),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('renders error message when StockScannerError', (tester) async {
      when(mockCubit.state).thenReturn(StockScannerError(error: 'Error'));

      await tester.pumpWidget(
        MaterialApp(
          home: StockScannerPage(mockCubit),
        ),
      );

      expect(find.text('Error'), findsOneWidget);
    });

    testWidgets('renders list of scanner results when StockScannerLoaded',
        (tester) async {
      final scannerResults = [
        const ScannerResult(
            id: 1,
            name: 'Test Result 1',
            tag: 'Tag 1',
            color: 'green',
            criteria: []),
        const ScannerResult(
            id: 2,
            name: 'Test Result 2',
            tag: 'Tag 2',
            color: 'red',
            criteria: []),
      ];
      when(mockCubit.state)
          .thenReturn(StockScannerLoaded(data: scannerResults));

      await tester.pumpWidget(
        MaterialApp(
          home: StockScannerPage(mockCubit),
        ),
      );

      expect(find.text('Test Result 1'), findsOneWidget);
      expect(find.text('Tag 1'), findsOneWidget);
      expect(find.text('Test Result 2'), findsOneWidget);
      expect(find.text('Tag 2'), findsOneWidget);
      expect(find.byType(VariableText), findsNothing);
    });
  });
}
