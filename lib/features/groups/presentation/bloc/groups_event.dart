part of 'groups_bloc.dart';

sealed class GroupsEvent extends Equatable {
  const GroupsEvent();

  @override
  List<Object> get props => [];
}

final class CreateGroup extends GroupsEvent {
  final CreateGroupBody body;

  const CreateGroup({required this.body});
}

final class JoinGroup extends GroupsEvent {}
