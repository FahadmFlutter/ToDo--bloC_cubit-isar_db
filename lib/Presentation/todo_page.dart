/*

TO DO PAGE: responsible for providing cubit to view (UI)

- use BlocProvider

*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/Presentation/todo_cubit.dart';

class TodoPage extends StatelessWidget {
  final TodoPage todoRepo;

  const TodoPage({super.key, required this.todoRepo});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit(todoRepo),
      child:  const TodoView( ),
    );
  }
}
