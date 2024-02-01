import 'package:flutter/material.dart';
import 'package:stock_scanner/home/ui/variable_indicator_widget.dart';
import 'package:stock_scanner/home/ui/variable_value_widget.dart';

class VariablePage extends StatelessWidget {
  final String title;
  final List<dynamic> values;
  final String variableType;

  const VariablePage(this.title, this.values, this.variableType, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
            child: variableType == "indicator"
                ? VariableIndicatorWidget()
                : VariableValueWidget(values: values)));
  }
}
