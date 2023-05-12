import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_task/Core/const/colors.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    DateFormat('HH:MM a').format(DateTime.now()),
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    DateFormat('HH:MM a').format(DateTime.now()),
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
              SvgPicture.asset(
                'assets/icons/check.svg',
                width: 10.w,
              ),
              SizedBox(
                width: 2.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Design todo list',
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
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
                      'I shoud Design  todo list today,Tick the done options.',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
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
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      child: Text(
                        'edit tasks',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: (Theme.of(context).brightness ==
                                      Brightness.light)
                                  ? Colors.black
                                  : AppColors.white,
                              fontSize: 12.sp,
                            ),
                      ),
                    ),
                    PopupMenuItem(
                      child: Text(
                        'delete tasks',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
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
  }
}
