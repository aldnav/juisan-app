import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'stock_for_edit_event.dart';
part 'stock_for_edit_state.dart';

class StockForEditBloc extends Bloc<StockForEditEvent, StockForEditState> {
  StockForEditBloc() : super(StockForEditInitial(-1)) {
    on<StockForEditSelected>((event, emit) {
      emit(StockForEditUpdated(event.stockId));
    });
  }
}
