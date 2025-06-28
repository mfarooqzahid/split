import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:split/features/groups/data/models/group.dart';
import 'package:split/features/groups/data/repository/group_repository.dart';

part 'groups_event.dart';
part 'groups_state.dart';

class GroupsBloc extends Bloc<GroupsEvent, GroupsState> {
  final GroupRepository repository;
  GroupsBloc({required this.repository}) : super(GroupsInitial()) {
    on<CreateGroup>(_onCreateGroupEvent);
  }

  Future<void> _onCreateGroupEvent(CreateGroup event, Emitter emit) async {
    emit(GroupLoading());

    final result = await repository.createGroup(body: event.body);

    result.fold(
      (failure) => emit(GroupFailure(failure.message)),
      (success) => emit(GroupSuccess()),
    );
  }
}
