part of 'stock_for_edit_bloc.dart';

abstract class StockForEditState extends Equatable {
  const StockForEditState(this.stockId);
  final int stockId;
  @override
  List<Object> get props => [stockId];
}

class StockForEditInitial extends StockForEditState {
  const StockForEditInitial(int stockId) : super(stockId);
}

class StockForEditUpdated extends StockForEditState {
  const StockForEditUpdated(int stockId) : super(stockId);
}
