import 'package:flutter/material.dart';

class VariableIndicatorWidget extends StatefulWidget {
  final Map<String, dynamic> indicator;

  const VariableIndicatorWidget({super.key, required this.indicator});

  @override
  State<VariableIndicatorWidget> createState() =>
      _VariableIndicatorWidgetState();
}

class _VariableIndicatorWidgetState extends State<VariableIndicatorWidget> {
  late TextEditingController _defaultController;

  @override
  void initState() {
    super.initState();
    _defaultController = TextEditingController(
      text: widget.indicator['default_value'].toString(),
    );
  }

  @override
  void dispose() {
    _defaultController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Set Parameters"),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Period"),
              SizedBox(
                width: 80,
                child: TextField(
                  controller: _defaultController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Period',
                  ),
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
