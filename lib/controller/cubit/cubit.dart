import 'package:crud_final/controller/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class ControllerCubit extends Cubit<TodoStates> {
  ControllerCubit() : super(InitialTodoState());

  static ControllerCubit get(context) => BlocProvider.of(context);
}