import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/scanner_result.dart';
import 'stock_scanner_cubit.dart';

class StockScannerPage extends StatelessWidget {
  final StockScannerCubit stockScannerCubit;

  const StockScannerPage(
    this.stockScannerCubit, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('Stock Scanner 👀'),
      ),
      body: BlocBuilder<StockScannerCubit, StockScannerState>(
        bloc: stockScannerCubit,
        builder: (context, state) {
          if (state is StockScannerInitial || state is StockScannerLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is StockScannerLoaded) {
            return ListView.builder(
                itemCount: state.data.length,
                itemBuilder: (context, index) {
                  final scannerResult = state.data[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 2.0,
                      child: ExpansionTile(
                        title: Text(scannerResult.name),
                        subtitle: Text(
                          scannerResult.tag,
                          style: TextStyle(
                              color: getColorFromScannerResult(scannerResult)),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: scannerResult.criteria.map((criteria) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: buildCriteriaText(criteria),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          } else if (state is StockScannerError) {
            return Center(child: Text(state.error));
          } else {
            return const Center(child: Text('Unknown state'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          stockScannerCubit.fetchData();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Color getColorFromScannerResult(ScannerResult scannerResult) {
    switch (scannerResult.color) {
      case 'green':
        return Colors.green;
      case 'red':
        return Colors.red;
      default:
        return Colors.black;
    }
  }
}

Widget buildCriteriaText(Criteria criteria) {
  if (criteria.type == 'variable') {
    return buildVariableText(criteria.text, criteria.variable);
  } else if (criteria.type == 'plain_text') {
    return Text(criteria.text);
  } else {
    return Container();
  }
}

Widget buildVariableText(String text, Map<String, dynamic>? variable) {
  final List<TextSpan> textSpans = [];

  final List<String> parts = text.split(" ");

  for (var i = 0; i < parts.length; i++) {
    if (i < parts.length) {
      List<dynamic> values = [];
      final String variableKey = parts[i];
      if (variable!.containsKey(variableKey)) {
        values = variable[variableKey]['values'] ?? [];
      }

      if (values.isNotEmpty) {
        textSpans.add(
          TextSpan(
            text: "${parts[i]} ",
            style: const TextStyle(
              color: Colors.blue,
              // decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                print('Tapped on variable: $variableKey, values: $values');
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
