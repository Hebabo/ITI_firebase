import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebaseiti/tasks/bloc/fires_stor_repo.dart';
import 'package:firebaseiti/tasks/models/task_model.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final FiresStorRepo _firesStorRepo;
  StreamSubscription<List<Task>>? _streamSubscription;

  TaskBloc(this._firesStorRepo) : super(TaskInitialState()) {
    on<LoadTasksEvent>(_onLoadTasks);
    on<AddTaskEvent>(_onAddTask);
    on<UpdateTaskEvent>(_onUpdateTask);
    on<DeleteTaskEvent>(_onDeleteTask);
    // on<ToggleTaskCompletionEvent>(_onToggleTaskCompletion);
  }

  // Load Tasks from Firestore
  Future<void> _onLoadTasks(
    LoadTasksEvent event,
    Emitter<TaskState> emit,
  ) async {
    emit(TaskLoadingState());
    await _streamSubscription?.cancel();

    _streamSubscription = _firesStorRepo
        .getTasks('createdAt')
        .listen(
          (tasks) {
            emit(TaskLoadedState(tasks));
            // add(UpdateTaskEvent(tasks));
          },
          onError: (error) {
            emit(TaskLoadingFaildState(msg: 'Failed to load tasks'));
          },
        );
  }

  // Add Task
  Future<void> _onAddTask(AddTaskEvent event, Emitter<TaskState> emit) async {
    try {
      await _firesStorRepo.addTask(event.task);
      emit(TaskAddingSuccessState(msg: 'Task added successfully'));
    } catch (e) {
      emit(TaskAddingFaildState(msg: 'Failed to add task'));
    }
  }

  // Update Task
  Future<void> _onUpdateTask(
    UpdateTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    try {
      await _firesStorRepo.updataTask(event.task);
      emit(TaskAddingSuccessState(msg: 'Task updated successfully'));
    } catch (e) {
      emit(TaskAddingFaildState(msg: 'Failed to update task'));
    }
  }

  // Delete Task
  Future<void> _onDeleteTask(
    DeleteTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    try {
      await _firesStorRepo.deleteTask(event.taskId);
      emit(TaskAddingSuccessState(msg: 'Task deleted successfully'));
    } catch (e) {
      emit(TaskAddingFaildState(msg: 'Failed to delete task'));
    }
  }

  // Toggle Task Completion
  Future<void> _onToggleTaskCompletion(
    ToggleTaskCompletionEvent event,
    Emitter<TaskState> emit,
  ) async {
    try {
      await _firesStorRepo.toggleTaskCompletion(event.task);
      emit(TaskCompletedstate(isCompeleted: !event.task.isCompleted));
    } catch (e) {
      emit(TaskAddingFaildState(msg: 'Failed to toggle task completion'));
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
