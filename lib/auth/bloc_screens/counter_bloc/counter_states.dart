part of 'counter_bloc.dart';

abstract class CounterStates {
  final int counter;

  CounterStates(this.counter);
}

class InitialCounterState extends CounterStates {
  InitialCounterState(super.counter);
}

class IncrementState extends CounterStates {
  final String msg;
  IncrementState(super.counter, this.msg);
}

class DecrementState extends CounterStates {
  final String msg;
  DecrementState(super.counter, this.msg);
}
