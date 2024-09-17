import 'package:bloc/bloc.dart';
import 'package:bloc_state/bloc/todo/to_do_event.dart';
import 'package:bloc_state/bloc/todo/to_do_state.dart';
import 'package:meta/meta.dart';

class ToDoBloc extends Bloc<TodoEvent, ToDoState> {

  final List<String> todoList = [];
  ToDoBloc() : super(ToDoState()){
    on<AddTodoEvent>(_addToDoEvent);
    on<RemoveTodoEvent>(_removeToDoEvent);
  }

  void _addToDoEvent(AddTodoEvent event, Emitter<ToDoState> emit){
    todoList.add(event.task);
    emit(state.copyWith(todoList: List.from(todoList)));
  }

void _removeToDoEvent(RemoveTodoEvent event, Emitter<ToDoState> emit){
    todoList.remove(event.task);
    emit(state.copyWith(todoList: List.from(todoList)));
  }






}
