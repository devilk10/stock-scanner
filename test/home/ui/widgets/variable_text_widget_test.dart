import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stock_scanner/home/ui/widgets/variable_text_widget.dart';

void main() {
  testWidgets('VariableText renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: VariableText(
            text: 'hello variable \$1',
            variable: {
              "\$1": {
                "type": "value",
                "values": [1, 2, 3, 5]
              }
            },
            title: 'title',
          ),
        ),
      ),
    );

    expect(find.byType(RichText), findsOneWidget);
  });
}
