import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'stock_for_edit_event.dart';
part 'stock_for_edit_state.dart';

class StockForEditBloc extends Bloc<StockForEditEvent, StockForEditState> {
  StockForEditBloc() : super(const StockForEditInitial(-1)) {
    on<StockForEditSelected>((event, emit) {
      emit(StockForEditUpdated(event.stockId));
    });
    on<StockForEditIsSaving>((event, emit) {
      emit(const StockForEditUpdated(-1));
    });
  }
}
