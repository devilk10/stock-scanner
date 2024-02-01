import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:stock_scanner/home/data/scanner_result.dart';

import '../../data/stock_scanner_repository.dart';

part 'stock_scanner_state.dart';

class StockScannerCubit extends Cubit<StockScannerState> {
  final StockScannerRepository _repository;

  StockScannerCubit(this._repository) : super(StockScannerInitial());

  Future<void> fetchData() async {
    emit(StockScannerLoading());
    try {
      final List<ScannerResult> data = await _repository.fetchData();
      emit(StockScannerLoaded(data: data));
    } catch (e) {
      print(e);
      emit(StockScannerError(error: 'Failed to fetch data'));
    }
  }
}
