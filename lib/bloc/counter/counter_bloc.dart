import 'package:bloc/bloc.dart';
import 'package:bloc_state/bloc/counter/counter_event.dart';
import 'package:bloc_state/bloc/counter/counter_state.dart';
class CounterBloc extends Bloc<CounterEvent,CounterState>{
  //create constructor nd in super we give the state of the counter
  //in super inital state of bloc
  //in this constructor we change the value of counter but intitilzation
  // in counterstate is best
  //super have inital state

  CounterBloc():super( const CounterState()){
    //syntax
    //on required twothings event nd emit nde in emitter we give state
    on<IncrementCounter>(_increment);
    on<DecrementCounter>(_decrement);
  }
 void _increment(IncrementCounter event ,Emitter<CounterState> emit){
    //write logic here
    //emit function emit state   .....emit act as setstate
emit(state.copyWith(counter: state.counter+1));

 }


  void _decrement(DecrementCounter event ,Emitter<CounterState> emit){
    //emit function emit state
    emit(state.copyWith(counter: state.counter-1));

  }
}