import 'package:flutter_bloc/flutter_bloc.dart';
part 'counter_events.dart';
part 'counter_states.dart';

class CounterBloc extends Bloc<CounterEvent, CounterStates> {
  CounterBloc() : super(InitialCounterState(0)) {
    on<IncrementButtonPressdEvent>(_onIncrement);
    on<DecrementButtonPressdEvent>(_onDecrement);
  }

  void _onIncrement(
    IncrementButtonPressdEvent event,
    Emitter<CounterStates> emit,
  ) {
    final newcount = state.counter + event.amount;
    emit(IncrementState(newcount, "Counter incremented by ${event.amount}"));
  }

  void _onDecrement(
    DecrementButtonPressdEvent event,
    Emitter<CounterStates> emit,
  ) {
    final newcount = state.counter - event.amount;
    emit(DecrementState(newcount, "Counter decremented by ${event.amount}"));
  }
}
