import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stock_scanner/home/ui/widgets/variable_indicator_widget.dart';

void main() {
  testWidgets('VariableIndicatorWidget displays parameters correctly',
      (tester) async {
    final Map<String, dynamic> testIndicator = {
      'default_value': 10,
    };

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: VariableIndicatorWidget(indicator: testIndicator),
        ),
      ),
    );

    await tester.pump();

    expect(find.text('Set Parameters'), findsOneWidget);
    expect(find.text('Period'), findsOneWidget);

    expect(find.text('10'), findsOneWidget);
  });
}
