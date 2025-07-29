part of 'counter_bloc.dart';

abstract class CounterEvent {
  
}

class IncrementButtonPressdEvent extends CounterEvent {
  final int amount;
  IncrementButtonPressdEvent(this.amount);
}

class DecrementButtonPressdEvent extends CounterEvent {
  final int amount;
  DecrementButtonPressdEvent(this.amount);
}
