

//abstrct class act as a base class nd define the behaviour or interface
//that other classes inherit it or implemet by its sub classes
//abstract class  does not intiliaze
//cunter event increment or dec on sub classes implement it feature or behaviur
import 'package:equatable/equatable.dart';
//with this counter class  pass to bloc we access all its sub classes
//abstract class act as a base class
abstract class CounterEvent extends Equatable{
   const CounterEvent();

   //th is equatable pkg method
   @override

  List<Object?> get props => [ ];


}
//these two are event classes
//sub class extend the counter class implemt counter clas functionality
class IncrementCounter extends CounterEvent{

}



class DecrementCounter extends CounterEvent{

}
