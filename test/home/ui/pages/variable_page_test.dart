import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stock_scanner/home/ui/pages/variable_page.dart';
import 'package:stock_scanner/home/ui/widgets/variable_indicator_widget.dart';
import 'package:stock_scanner/home/ui/widgets/variable_value_widget.dart';

void main() {
  testWidgets(
      'VariablePage displays VariableIndicatorWidget if variableType is "indicator"',
      (WidgetTester tester) async {
    final Map<String, dynamic> testValues = {
      'default_value': 10,
    };

    await tester.pumpWidget(
      MaterialApp(
        home: VariablePage('Title', testValues, 'indicator'),
      ),
    );

    await tester.pump();

    expect(find.byType(VariableIndicatorWidget), findsOneWidget);

    expect(find.byType(VariableValueWidget), findsNothing);
  });

  testWidgets(
      'VariablePage displays VariableValueWidget if variableType is not "indicator"',
      (WidgetTester tester) async {
    final Map<String, dynamic> testValues = {
      'values': [1, 2, 3],
    };

    await tester.pumpWidget(
      MaterialApp(
        home: VariablePage('Title', testValues, 'otherType'),
      ),
    );

    await tester.pump();

    expect(find.byType(VariableValueWidget), findsOneWidget);

    expect(find.byType(VariableIndicatorWidget), findsNothing);
  });
}
