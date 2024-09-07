/*

TO DO VIEW: responsible for UI

- use BlocBuilder

*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/Presentation/todo_cubit.dart';

import '../Domain/Models/todo.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  // show dialog box for user to type
  void _showAddTodoBox(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    final textController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add TODO'),
        content: TextField(controller: textController,decoration: const InputDecoration(
          hintText: 'Homework',
          helperStyle: TextStyle(fontWeight: FontWeight.w100)
        ),),
        actions: [
          // cancel button
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),

          // add button
          TextButton(
            onPressed: () {
              todoCubit.addTodo(textController.text);
              Navigator.of(context).pop();
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  // BUILD UI
  @override
  Widget build(BuildContext context) {
    // todo cubit
    final todoCubit = context.read<TodoCubit>();

    // SCAFFOLD
    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO app'),

      ),
      // FAB
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Add TODO'),
        onPressed: () => _showAddTodoBox(context),
        icon: const Icon(Icons.add),
      ),

      // BLOC BUILDER
      body: BlocBuilder<TodoCubit, List<Todo>>(
        builder: (context, todos) {
          // List View
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              // get individual todo from todos list
              final todo = todos[index];

              // List Tile UI
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Card(
                  elevation: 0,
                  child: ListTile(
                    // text
                    title: Text(
                      todo.text,
                      style: TextStyle(
                        decoration: todo.isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),

                    // check box
                    leading: Checkbox(
                      value: todo.isCompleted,
                      onChanged: (value) => todoCubit.toggleCompletion(todo),
                    ),

                    // delete button
                    trailing: IconButton(
                      icon:  Icon(Icons.delete_outline,color: Theme.of(context).colorScheme.error.withOpacity(0.5),),
                      onPressed: () => todoCubit.deleteTodo(todo),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}