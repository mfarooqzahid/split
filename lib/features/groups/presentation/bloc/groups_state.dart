part of 'groups_bloc.dart';

sealed class GroupsState extends Equatable {
  const GroupsState();

  @override
  List<Object> get props => [];
}

final class GroupsInitial extends GroupsState {}

final class GroupLoading extends GroupsState {}

final class GroupSuccess extends GroupsState {}

final class GroupFailure extends GroupsState {
  final String message;

  const GroupFailure(this.message);

  @override
  List<Object> get props => [message];
}
