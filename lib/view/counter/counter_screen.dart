import 'package:bloc_state/bloc/counter/counter_bloc.dart';
import 'package:bloc_state/bloc/counter/counter_event.dart';
import 'package:bloc_state/bloc/counter/counter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  late CounterBloc _counterBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _counterBloc =CounterBloc();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _counterBloc.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => _counterBloc,
      child: Scaffold(
        appBar: AppBar
          (
          title: Text('Counter Screen'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //just like consumer in provider here we user bloc provider
            //to update the state on ui
            BlocBuilder<CounterBloc,CounterState>(
              builder: (context, state) {
                return Center(child: Text(state.counter.toString(), style: TextStyle(fontSize: 60),));
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BlocBuilder<CounterBloc,CounterState>(
                  buildWhen: (current, previous) => false,
                  builder: (context, state) {
                    return ElevatedButton(onPressed: () {
                      //syntax to trigger event
                      context.read<CounterBloc>().add(IncrementCounter());
                    }, child: Text('Incremenet'));
                  },
                ),
                SizedBox(width: 20,),
                BlocBuilder<CounterBloc,CounterState>(
                  buildWhen: (current, previous) => false,
                  builder: (context, state) {
                    return ElevatedButton(onPressed: () {
                      context.read<CounterBloc>().add(DecrementCounter());
                    }, child: Text('Decrement'));
                  },
                ),

              ],

            )

          ],
        ),
      ),
    );
  }
}
