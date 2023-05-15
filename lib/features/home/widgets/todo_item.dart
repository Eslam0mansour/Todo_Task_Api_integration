import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_task/Core/const/colors.dart';
import 'package:todo_task/features/home/cubit/home_cubit.dart';
import 'package:todo_task/features/home/cubit/home_staets.dart';
import 'package:todo_task/features/home/data/models/todo_data.dart';

class TodoItem extends StatelessWidget {
  final TodoData item;
  final int listId;

   TodoItem({
    Key? key,
    required this.item,
    required this.listId,
  }) : super(key: key);
final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 5.w,
            vertical: 1.h,
          ),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              padding: EdgeInsets.only(
                left: 5.w,
                right: 5.w,
                top: 2.h,
                bottom: 2.h,
              ),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text(
                        DateFormat('HH:MM a').format(item.createdOn!),
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 9.sp,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text(
                        DateFormat('dd/MM/yyyy').format(item.createdOn!),
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 9.sp,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  IconButton(
                    onPressed: () {
                      HomeCubit.get(context).ubdateTodo(
                        description: item.description!,
                        id: item.id!,
                        isCompleted: !item.isCompleted!,
                        todoListId: listId,
                        name: item.name!,
                      );
                    },
                    icon: SvgPicture.asset(
                      'assets/icons/${item.isCompleted! ? 'check' : 'uncheck'}.svg',
                      width: 22.sp,
                    ),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name!,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                color: (Theme.of(context).brightness ==
                                        Brightness.light)
                                    ? Colors.black
                                    : AppColors.white,
                                fontSize: 12.sp,
                              ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          item.description!,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 7.sp,
                                    color: Colors.grey[400],
                                  ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  PopupMenuButton(
                    iconSize: 20.sp,
                    icon: Icon(
                      Icons.more_vert,
                      color: Colors.grey[400],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onSelected: (value) {
                      if (value == 'edit tasks') {
                        _nameController.text = item.name!;
                        _descriptionController.text = item.description!;
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                'Edit Task',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                      color: (Theme.of(context).brightness ==
                                              Brightness.light)
                                          ? Colors.black
                                          : AppColors.white,
                                      fontSize: 12.sp,
                                    ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              content: Container(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextFormField(
                                      controller: _nameController,
                                      decoration: InputDecoration(
                                        hintText: 'Task Name',
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              fontSize: 12.sp,
                                              color: Colors.grey[400],
                                            ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    TextFormField(
                                      controller: _descriptionController,
                                      decoration: InputDecoration(
                                        hintText: 'Task Description',
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              fontSize: 12.sp,
                                              color: Colors.grey[400],
                                            ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Cancel',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                          color:
                                              (Theme.of(context).brightness ==
                                                      Brightness.light)
                                                  ? Colors.black
                                                  : AppColors.white,
                                          fontSize: 12.sp,
                                        ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    HomeCubit.get(context).ubdateTodo(
                                      description: _descriptionController.text,
                                      id: item.id!,
                                      isCompleted: item.isCompleted!,
                                      todoListId: listId,
                                      name: _nameController.text,
                                    );
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Update',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                          color:
                                              (Theme.of(context).brightness ==
                                                      Brightness.light)
                                                  ? Colors.black
                                                  : AppColors.white,
                                          fontSize: 12.sp,
                                        ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      } else if (value == 'delete tasks') {
                        context.read<HomeCubit>().deleteTodo(
                              id: item.id!,
                              todoListId: listId,
                            );
                      }
                    },
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          value: 'edit tasks',
                          child: Text(
                            'edit tasks',
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: (Theme.of(context).brightness ==
                                              Brightness.light)
                                          ? Colors.black
                                          : AppColors.white,
                                      fontSize: 12.sp,
                                    ),
                          ),
                        ),
                        PopupMenuItem(
                          value: 'delete tasks',
                          child: Text(
                            'delete tasks',
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: (Theme.of(context).brightness ==
                                              Brightness.light)
                                          ? Colors.black
                                          : AppColors.white,
                                      fontSize: 12.sp,
                                    ),
                          ),
                        ),
                      ];
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
