import 'package:flutter/material.dart';

class VariableValueWidget extends StatelessWidget {
  final List<dynamic> values;

  const VariableValueWidget({super.key, required this.values});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: values.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 1),
          child: Card(
            elevation: 2.0,
            child: ListTile(
              title: Text(
                values[index].toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
