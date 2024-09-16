import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class EquatableTestState extends StatefulWidget {
  const EquatableTestState({super.key});

  @override
  State<EquatableTestState> createState() => _EquatableTestStateState();
}

class _EquatableTestStateState extends State<EquatableTestState> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        //value of both obj are same
        Person person =Person(name: 'Anamb', age: 31);
        Person person1 =Person(name: 'Anam', age: 11);

        //equatabel pkg used for equality is better in flutter other wise it says they are not equal
        //by defualt in fluterr on instance equalto itself only for that comparisn used hash code
        print(person = person1);
        print(person = person);
        //or
        print( person.hashCode.toString());
        print( person1.hashCode.toString());
      }),
    );
  }
}



//equatable testing
class Person extends Equatable{
  final String name;
  final int age;

  Person({required this.name, required this.age});

  @override
  //in this list write all variables in array form
  List<Object?> get props => [name,age];

}