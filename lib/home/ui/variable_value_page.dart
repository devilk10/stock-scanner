import 'package:flutter/material.dart';

class ValuePage extends StatelessWidget {
  final String variableKey;
  final List<dynamic> values;

  const ValuePage(this.variableKey, this.values, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Value Page - $variableKey'),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: values.length,
            itemBuilder: (context, index) {
              return Text(values[index].toString());
            }),
      ),
    );
  }
}
