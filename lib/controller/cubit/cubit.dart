import 'package:crud_final/controller/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class TodoCubit extends Cubit<TodoStates> {
  TodoCubit() : super(InitialTodoState());

  static TodoCubit get(context) => BlocProvider.of(context);

// SQl Lite
// Create our database
// create database file
// create database table
// open database file
  Database? database;

// if we have a path file name so we just open it
  // if we don't have a path file name we created it
  void createDatabase() {
    // path here is the file name
    // db DataBase
    openDatabase('was.db', version: 1, onCreate: (database, version) {
      // here our database is create (only for the first time)
      // if we don't the path file name
      print('The database is created');
      database
          .execute('CREATE TABLE tasks'
              '(id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, description TEXT)')
          .then((value) {
        // here the table is created
        print('our table is created');
      }).catchError((error) {
        // here is an error when creating our table
        print('an error when creating the table');
      });
    }, onOpen: (database) {
      print('database file is opened');
    }).then((value) {
      // the database file is succeed to open
      database = value;
      emit(CreateTodoDatabaseState());
    }).catchError((error) {
      print('error when opening the file');
    });
  }

 void insertToDatabase({
  required String title,
  required String date,
  required String time,
  required String description,
 }) {
    database!.transaction((txn) async {
      // insert into tableName
      txn
          .rawInsert('INSERT INTO tasks'
              '(title, date, time, description)' 
              'VALUES ("$title", "$date", "$time", "$description")')
          .then((value) {
        print('$value is inserted successfully');
        gettingDataFromDatabase();
        emit(InsertingIntoTodoDatabaseState());
      }).catchError((error) {
        print('an error when inserting into database');
      });
    });
  }

  List tasks = [];
  void gettingDataFromDatabase(){
    tasks = [];
    // * called "ALL"
    // SELECT * from "table_name"

    database!.rawQuery('SELECT * FROM tasks').then((value)
    {
      value.forEach((element){
        tasks.add(element);
      });
      print('our data is appearing');
      print(value);
      emit(SuccessGettingDataFromDatabaseState());
    }).catchError((error){
      print('an error when getting data from database ${error.toString()}');
    });
  }

  void updateDataIntoDatabase({
    required String title,
    required String date,
    required String time,
    required String description,
    required int id,
  })
  {
    // apa yang ingin kita update
    // to reach for a task from a table is by ID
    database!.update('tasks', {"title":title, "date":date, "time":time, "description":description
    },
    where: 'id =?',
    whereArgs: [id]
    ).then((value){
      print('$value updating data has successfully happened');
      gettingDataFromDatabase();
    }).catchError((error){
      print('error when updating data to database');
    });
  }

  void deleteDataFromDatabase({required int id})
  {
    database!.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value)
    {
      print('$value deleted successfully');
      gettingDataFromDatabase();
    }).catchError((error){
      print('an error when deleting data');
    });
  }
}