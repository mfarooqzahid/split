part of 'billdetails_bloc.dart';

sealed class BilldetailsState extends Equatable {
  const BilldetailsState();
  
  @override
  List<Object> get props => [];
}

final class BilldetailsInitial extends BilldetailsState {}
