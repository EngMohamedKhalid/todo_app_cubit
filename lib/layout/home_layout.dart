// ignore_for_file: avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/shared/component/custom_text_field.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';
import 'package:todo_app/shared/style/colors.dart';

class HomeLayout extends StatelessWidget {
   HomeLayout({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController titleCont = TextEditingController();
  final TextEditingController timeCont = TextEditingController();
  final TextEditingController dateCont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit,AppStates>(
         listener: (BuildContext context,AppStates state) {
           if(state is AppInsertDatabaseState ){
             Navigator.pop(context);
             timeCont.clear();
             dateCont.clear();
             titleCont.clear();
           }
         },
        builder: (BuildContext context,AppStates state) {
         var cubit = AppCubit.getObject(context);
          return Scaffold(
              resizeToAvoidBottomInset: true,
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor:primaryColor,
            centerTitle: true,
            title: Text(
              cubit.listTitles[cubit.currentIndex],
              style:  TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: primaryColor,
            selectedFontSize: 18.sp,
            currentIndex: cubit.currentIndex,
            onTap: (value) {
              cubit.changeCurrent(value);
            },
            type: BottomNavigationBarType.fixed,
            items:  [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.menu,
                    size: 35.sp,
                  ),
                  label: "Tasks"
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.done,
                    size: 35.sp,
                  ),
                  label: "Done"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.archive,
                    size: 35.sp,
                  ),
                  label: "Archived"),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor:primaryColor,
            onPressed: () {
              if(cubit.isBottomSheetOpened){
                if(formKey.currentState!.validate()){
                  cubit.insertToDatabase(title: titleCont.text,date: dateCont.text,time: timeCont.text);
                }
              }
              else{
                scaffoldKey.currentState!.showBottomSheet(
                    elevation: 50,
                        (context) {
                      return Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black,
                                primaryColor,
                              ],
                              end: Alignment.centerRight,
                              begin: Alignment.centerLeft,
                            ),
                            borderRadius:const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            )
                        ),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              customStatelessTextField(
                                controller: titleCont,
                                keyType: TextInputType.text,
                                hintText: "Task title",
                                padding: EdgeInsets.only(top: 5.h ,right: 15.w,left: 15.w,bottom: 10.h),
                                prefix:  Icon(
                                  Icons.title,
                                  size: 28.sp,
                                  color: Colors.white,
                                ),
                                onTap: () {},
                              ),
                              customStatelessTextField(
                                controller: timeCont,
                                keyType: TextInputType.none,
                                hintText: "Task time",
                                padding:const EdgeInsets.only(right: 15,left: 15,bottom: 10),
                                prefix:  Icon(
                                  Icons.watch_later_sharp,
                                  size: 28.sp,
                                  color: Colors.white,
                                ),
                                onTap: () {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((value) {
                                    timeCont.text = value!.format(context);
                                  });
                                },
                              ),
                              customStatelessTextField(
                                controller: dateCont,
                                keyType: TextInputType.none,
                                hintText: "Task date",
                                padding:const EdgeInsets.only(right: 15,left: 15,bottom: 10),
                                prefix:  Icon(
                                  Icons.date_range_sharp,
                                  size: 28.sp,
                                  color: Colors.white,
                                ),
                                onTap: () {
                                  showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse("2222-12-31")
                                  ).then((value) {
                                    dateCont.text = DateFormat.yMMMd().format(value!);
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    }).closed.then((value){

                  cubit.changeBottomSheetIcon(false);

                });
                cubit.changeBottomSheetIcon(true);
              }
            },
            child:cubit.isBottomSheetOpened?
             Icon(
              Icons.add_circle_sharp,
              size: 35.sp,
            )
                :
             Icon(
              Icons.edit_sharp,
              size: 35.sp,
            )
            ,
          ),
          body: ConditionalBuilder(
            condition: true,
            builder:(context) =>cubit.listWidgets[cubit.currentIndex] ,
            fallback:(context) =>const Center(child: CircularProgressIndicator()),
          ),
        );
        }
      ),
    );
  }


}


