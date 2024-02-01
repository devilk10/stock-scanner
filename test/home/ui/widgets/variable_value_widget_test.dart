import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stock_scanner/home/ui/widgets/variable_value_widget.dart';

void main() {
  testWidgets('VariableValueWidget displays values correctly',
      (WidgetTester tester) async {
    final List<dynamic> testValues = [1, 2, 3, 'Test'];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: VariableValueWidget(values: testValues),
        ),
      ),
    );

    await tester.pump();

    for (final value in testValues) {
      expect(find.text(value.toString()), findsOneWidget);
    }
  });
}
