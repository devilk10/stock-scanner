part of 'stock_scanner_cubit.dart';

@immutable
abstract class StockScannerState extends Equatable {}

class StockScannerInitial extends StockScannerState {
  @override
  List<Object?> get props => [];
}

class StockScannerLoading extends StockScannerState {
  @override
  List<Object?> get props => [];
}

class StockScannerLoaded extends StockScannerState {
  final List<ScannerResult> data;

  StockScannerLoaded({required this.data});

  @override
  List<Object?> get props => [data];
}

class StockScannerError extends StockScannerState {
  final String error;

  StockScannerError({required this.error});

  @override
  List<Object?> get props => [error];
}
