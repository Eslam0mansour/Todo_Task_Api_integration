import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_task/Core/const/colors.dart';
import 'package:todo_task/features/home/widgets/todo_item.dart';

class TodosScreen extends StatelessWidget {
  const TodosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar:true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title:  Text(
          'Today’s task',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: AppColors.white,
            fontSize: 18.sp,
              )
          ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SvgPicture.asset(
            'assets/images/todo_screen.svg',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.75,
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return  const TodoItem();
              },
            ),
          ),
        ],
      ),
    );
  }
}

