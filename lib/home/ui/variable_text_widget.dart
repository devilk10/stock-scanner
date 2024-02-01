import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'variable_page.dart';

class VariableText extends StatelessWidget {
  final String text;
  final String title;
  final Map<String, dynamic>? variable;

  const VariableText({
    super.key,
    required this.text,
    required this.variable,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final List<TextSpan> textSpans = [];

    final List<String> parts = text.split(" ");

    for (var i = 0; i < parts.length; i++) {
      if (i < parts.length) {
        List<dynamic> values = [];
        final String variableKey = parts[i];
        if (variable!.containsKey(variableKey)) {
          values = variable![variableKey]['values'] ??
              [variable![variableKey]['default_value']] ??
              [];
        }

        if (values.isNotEmpty) {
          textSpans.add(
            TextSpan(
              text: "(${values[0]}) ",
              style: const TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return VariablePage(
                          title, values, variable![variableKey]['type']);
                    }),
                  );
                },
            ),
          );
        } else {
          textSpans.add(
            TextSpan(
              text: "${parts[i]} ",
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          );
        }
      }
    }

    return RichText(
      text: TextSpan(children: textSpans),
    );
  }
}
