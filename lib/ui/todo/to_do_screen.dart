import 'package:bloc_state/bloc/todo/to_do_bloc.dart';
import 'package:bloc_state/bloc/todo/to_do_event.dart';
import 'package:bloc_state/bloc/todo/to_do_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App'),
      ),
      body: BlocBuilder<ToDoBloc, ToDoState>(
          builder:(context, state){
            if(state.todolist.isEmpty){
              return Center(child: Text('No ToDos Found'),);
            }else if(state.todolist.isNotEmpty){
            return ListView.builder(
            itemCount: state.todolist.length,
            itemBuilder: (context, index){
              return ListTile(
                title: Text(state.todolist[index]),
                trailing: IconButton(
                    onPressed: (){
                      context.read<ToDoBloc>().add(RemoveTodoEvent(task: state.todolist[index]));

                    },
                    icon: Icon(Icons.delete)
                ),
              );
            }
         );
      }else{
              return SizedBox();
            }

          }
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            for(int i=0; i<5; i++){
            context.read<ToDoBloc>().add(AddTodoEvent(task: 'Task' + i.toString()));
            }
          },
        child: Icon(Icons.add),
      ),
    );
  }
}
