// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TaskInitialState extends TaskState {}

class TaskLoadingState extends TaskState {}

class TaskLoadedState extends TaskState {
  final List<Task> tasks;
  TaskLoadedState(this.tasks);

  @override
  List<Object?> get props => [tasks];
}

class TaskLoadingFaildState extends TaskState {
  final String msg;
  TaskLoadingFaildState({required this.msg});
}

class TaskCompletedstate extends TaskState {
  final bool isCompeleted;
  TaskCompletedstate({required this.isCompeleted});
}

class TaskAddingFaildState extends TaskState {
  final String msg;
  TaskAddingFaildState({required this.msg});
}

class TaskAddingSuccessState extends TaskState {
  final String msg;
  TaskAddingSuccessState({required this.msg});
}
