part of 'stock_for_edit_bloc.dart';

abstract class StockForEditEvent extends Equatable {
  const StockForEditEvent(this.stockId);
  final int stockId;

  @override
  List<Object> get props => [stockId];
}

class StockForEditSelected extends StockForEditEvent {
  const StockForEditSelected(int stockId) : super(stockId);
}
