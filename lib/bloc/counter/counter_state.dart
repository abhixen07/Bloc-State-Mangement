import 'package:equatable/equatable.dart';
//state is not abstract
 class CounterState extends  Equatable{
   final int counter;

   const CounterState({ this.counter = 0});
   //function copy with copy of curent state with updated value
   //create new instance of class change value
   //this function change the vlaue of counter
   CounterState copyWith({int? counter}) {
     return CounterState(
       //if new value provide it update otherwise curent value
       counter: counter ?? this.counter,
     );
   }


   @override

  List<Object?> get props => [counter];

 }