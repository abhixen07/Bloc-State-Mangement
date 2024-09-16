import 'package:bloc_state/bloc/switch_example/switch_event.dart';
import 'package:bloc_state/bloc/switch_example/switch_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SwitchBloc extends Bloc<SwitchEvents,SwitchStates>{
  SwitchBloc():super(SwitchStates()){
    on<EnableDisableNotification>(_enabledisablenotification);
    on<SliderEvent>(_sliderchange);
  }
void _enabledisablenotification(EnableDisableNotification events,Emitter<SwitchStates> emit){
   emit(state.copyWith(isSwitch: !state.isSwitch));

  }
  void _sliderchange (SliderEvent events, Emitter<SwitchStates> emit){
    emit(state.copyWith(slider: events.slider));

  }
}