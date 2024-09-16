import 'package:bloc_state/bloc/switch_example/switch_bloc.dart';
import 'package:bloc_state/bloc/switch_example/switch_event.dart';
import 'package:bloc_state/bloc/switch_example/switch_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SwitchExampleScreen extends StatefulWidget {
  const SwitchExampleScreen({super.key});

  @override
  State<SwitchExampleScreen> createState() => _SwitchExampleScreenState();
}

class _SwitchExampleScreenState extends State<SwitchExampleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Example Two'),

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Notification'),
                BlocBuilder<SwitchBloc, SwitchStates>(
                  //build when we need this
                  buildWhen: (previous,current)=>  previous.isSwitch !=current.isSwitch,
                  builder: (context, state) {
                    return Switch(value: state.isSwitch, onChanged: (value) {

                      context.read<SwitchBloc>().add(EnableDisableNotification());
                    });
                  },
                )
              ],
            ),
            SizedBox(height: 30,),
            BlocBuilder<SwitchBloc, SwitchStates>(
              builder: (context, state) {
                return   Container(
                  height: 200,
                  color: Colors.red.withOpacity(state.slider),
                );
              },
            ),

            SizedBox(height: 50,),
            BlocBuilder<SwitchBloc, SwitchStates>(
              buildWhen: (previous,current)=>  previous.slider !=current.slider,
              builder: (context, state) {

                return  Slider(value: state.slider, onChanged: (value) {
                  context.read<SwitchBloc>().add(SliderEvent(slider: value));
                });
              },
            )


          ],
        ),
      ),
    );
  }
}
