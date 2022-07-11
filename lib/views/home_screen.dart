import 'package:crud_final/controller/cubit/cubit.dart';
import 'package:crud_final/controller/cubit/states.dart';
import 'package:crud_final/views/add_task_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var cubit = TodoCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return AddTaskScreen();
              }));
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
