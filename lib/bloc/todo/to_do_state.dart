import 'package:equatable/equatable.dart';

final class ToDoState extends Equatable {

  final List<String> todolist;
  const ToDoState({
    this.todolist = const []
});

  ToDoState copyWith({ List<String>? todoList}){
    return ToDoState(
      todolist: todoList ?? this.todolist
    );

  }

  @override
  List<Object> get props => [todolist];

}

