import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/style/colors.dart';

Widget customTaskItem(Map model , context) =>
    Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
         AppCubit.getObject(context).deleteStatus(id: model["id"]);
      },
      child: Padding(
  padding:  EdgeInsets.symmetric(
        vertical: 10.h,
        horizontal: 15.w
  ),
  child: Row(
      children: [
         CircleAvatar(
          radius: 40.sp,
          child: Text(
              "${model["time"]}",
          ),
        ),
         SizedBox(width: 20.w,),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${model["title"]}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp
                ),

              ),
              SizedBox(height: 5.h,),
              Text(
                "${model["date"]}",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500
                ),

              )
            ],
          ),
        ),
        SizedBox(width: 20.w,),
        IconButton(
            onPressed: () {
              AppCubit.getObject(context).updateStatus(status: "done", id: model["id"]);
            },
            icon:  Icon(
              Icons.done,
              size: 35.sp,
              color: primaryColor,
            ),
        ),
        SizedBox(width: 10.w,),
        IconButton(
            onPressed: () {
              AppCubit.getObject(context).updateStatus(status: "archived", id: model["id"]);
            },
            icon:  Icon(
              Icons.archive,
              size: 35.sp,
              color: primaryColor,
            ),
        ),
         SizedBox(width: 10.w,),
        IconButton(
          onPressed: () {
            AppCubit.getObject(context).updateStatus(status: "new", id: model["id"]);
          },
          icon:  Icon(
            Icons.task,
            size: 35.sp,
            color: primaryColor,
          ),
        ),
      ],
  ),
),
    );


