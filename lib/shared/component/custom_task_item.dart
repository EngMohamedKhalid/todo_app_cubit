import 'package:flutter/material.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/style/colors.dart';

Widget customTaskItem(Map model , context) =>
    Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
         AppCubit.getObject(context).deleteStatus(id: model["id"]);
      },
      child: Padding(
  padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 15
  ),
  child: Row(
      children: [
         CircleAvatar(
          radius: 40,
          child: Text(
              "${model["time"]}",
          ),
        ),
        const SizedBox(width: 20,),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${model["title"]}",
                style:const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),

              ),
             const SizedBox(height: 5,),
              Text(
                "${model["date"]}",
                style:const TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.w500
                ),

              )
            ],
          ),
        ),
        const SizedBox(width: 20,),
        IconButton(
            onPressed: () {
              AppCubit.getObject(context).updateStatus(status: "done", id: model["id"]);
            },
            icon:  Icon(
              Icons.done,
              size: 35,
              color: primaryColor,
            ),
        ),
        const SizedBox(width: 10,),
        IconButton(
            onPressed: () {
              AppCubit.getObject(context).updateStatus(status: "archived", id: model["id"]);
            },
            icon:  Icon(
              Icons.archive,
              size: 35,
              color: primaryColor,
            ),
        ),
      ],
  ),
),
    );


