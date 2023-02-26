// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/modules/archived_task/archived_task.dart';
import 'package:todo_app/modules/done_task/done_task.dart';
import 'package:todo_app/modules/new_task/new_task.dart';
import 'package:todo_app/shared/cubit/states.dart';
class AppCubit extends Cubit<AppStates>{
  AppCubit():super(InitialAppState());
  static  AppCubit getObject(context)=>BlocProvider.of(context);
  int currentIndex = 0;
  late Database database ;
  bool isBottomSheetOpened = false;
  List<Widget> listWidgets =const  [NewTaskScreen(), DoneTaskScreen(), ArchivedTaskScreen(),];
  List<String> listTitles = const ["New Task", "Done Task", "Archived Task",];
  List <Map> newTasks = [];
  List <Map> doneTasks = [];
  List <Map> archivedTasks = [];
  void changeCurrent(int index)
  {
    currentIndex = index;
    emit(AppChangeBNBar());
  }
  void changeBottomSheetIcon(bool isOpened){
    isBottomSheetOpened = isOpened;
    emit(AppChangeBottomSheetIconState());
  }
  void createDatabase(){
     openDatabase(
      "todo.db",
      version: 1,
      onCreate: (db, version) {
        print("database created");
        db.execute(
            "create table tasks (id INTEGER PRIMARY KEY , title TEXT , date TEXT , time TEXT , status TEXT)"
        ).then((value) {
          print("table created");
        }).catchError((onError){
          print("error${onError.toString()}");
        });
      },
      onOpen: (db) {
        getDataFromDatabase(db);
        print("database opened $db");
      },
    ).then((value){
      database =value ;
      emit(AppCreateDatabaseState());
     });
  }
  insertToDatabase({required String title,required String date,required String time})async{
     await database.transaction((txn) async{
      txn.rawInsert("insert into tasks (title,date,time,status) values ('$title' ,'$date','$time','new') ").then((value) {
        print("$value $txn insert Successfully");
        emit(AppInsertDatabaseState());
        getDataFromDatabase(database);
      }).catchError((onError){
        print("error${onError.toString()}");
      });
      return null;
    });
  }
  void getDataFromDatabase (database){
     newTasks = []; doneTasks = [];archivedTasks = [];
     emit(AppGetDatabaseState());
     database.rawQuery("select * from tasks").then((value){
       value.forEach((element) {
         if(element['status']=='new') {
           newTasks.add(element);
         }else if(element['status']=='done') {
           doneTasks.add(element);
         } else {
           archivedTasks.add(element);
         }
       });
       emit(AppGetDatabaseState());
     });
  }
  void updateStatus({required String status , required int id}){
    database.rawUpdate(
        "update tasks set status = ? where id = ?",
        [status ,id]
    ).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }
  void deleteStatus({ required int id}){
    database.rawDelete(
        "delete from tasks where id = ?",[id]
    ).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }
}