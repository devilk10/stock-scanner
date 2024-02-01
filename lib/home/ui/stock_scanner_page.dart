import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/scanner_result.dart';
import 'stock_scanner_cubit.dart';
import 'variable_text_widget.dart';

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
    return VariableText(
      text: criteria.text,
      variable: criteria.variable,
    );
  } else {
    return Text(criteria.text);
  }
}
