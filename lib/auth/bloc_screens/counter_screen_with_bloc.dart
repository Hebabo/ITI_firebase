import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_bloc/counter_bloc.dart';

class CounterScreenWithBloc extends StatelessWidget {
  const CounterScreenWithBloc({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Widget')),
      body: Center(
        child: BlocBuilder<CounterBloc, CounterStates>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Counter: ${state.counter}'),
                if (state is IncrementState)
                  Text(state.msg, style: TextStyle(color: Colors.green)),
                if (state is DecrementState)
                  Text(state.msg, style: TextStyle(color: Colors.red)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => context.read<CounterBloc>().add(IncrementButtonPressdEvent(1)),
                      child: const Text('Increment'),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () => context.read<CounterBloc>().add(DecrementButtonPressdEvent(1)),
                      child: const Text('Decrement'),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
