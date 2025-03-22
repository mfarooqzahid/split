import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'billdetails_event.dart';
part 'billdetails_state.dart';

class BilldetailsBloc extends Bloc<BilldetailsEvent, BilldetailsState> {
  BilldetailsBloc() : super(BilldetailsInitial()) {
    on<BilldetailsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
