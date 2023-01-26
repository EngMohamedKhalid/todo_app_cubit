import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/component/custom_task_item.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';
import 'package:todo_app/shared/style/colors.dart';

class ArchivedTaskScreen extends StatelessWidget {
  const ArchivedTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener :  (context, state) {},
        builder : (context, state) {
          var tasks = AppCubit.getObject(context).archivedTasks;
          return ConditionalBuilder(
              condition: tasks.isNotEmpty,
              builder: (context) => ListView.separated(
                itemCount:tasks.length,
                itemBuilder: (context, index) => customTaskItem(tasks[index] , context) ,
                separatorBuilder: (context, index) => Container(
                  margin:const EdgeInsets.symmetric(horizontal: 20),
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey[300],
                ),
              ),
              fallback: (context) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.menu,
                      size: 100,
                      color: primaryColor,
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      "No Tasks yet , Please Add Some Tasks",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: primaryColor
                      ),
                    )
                  ],
                ),
              ) ,
            );
        }

    );
  }
}
