import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_task/Core/const/colors.dart';
import 'package:todo_task/features/authentication/presentation/widgets/my_form_field.dart';
import 'package:todo_task/features/home/presentation/cubit/home_cubit.dart';
import 'package:todo_task/features/home/presentation/cubit/home_staets.dart';
import 'package:todo_task/features/home/presentation/widgets/todo_item.dart';

class TodosScreen extends StatelessWidget {
  final int listId;
   TodosScreen({Key? key,
    required this.listId,
  }) : super(key: key);
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController iconController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Today’s task',
            style: Theme
                .of(context)
                .textTheme
                .headlineSmall!
                .copyWith(
              color: AppColors.white,
              fontSize: 18.sp,
            )),
        centerTitle: true,
        actions: [
        //  delete list
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  context.read<HomeCubit>().deleteListOfTodos(
                    id: listId
                  );
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.delete,
                  color: AppColors.white,
                ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          SvgPicture.asset(
            'assets/images/todo_screen.svg',
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: MediaQuery
                .of(context)
                .size
                .height * 0.75,
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is HomeLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is HomeSuccessState && context.read<HomeCubit>().listsOfTodos.isNotEmpty) {
                  return ListView.builder(
                    itemCount: context.read<HomeCubit>().listsOfTodos.length,
                    itemBuilder: (context, index) {
                      return TodoItem(
                        item: context.read<HomeCubit>().listsOfTodos[index],
                        listId: listId,
                      );
                    },
                  );
                } else if (state is HomeSuccessState && context.read<HomeCubit>().listsOfTodos.isEmpty) {
                  return  Center(
                    child: Text('No Todos Yet' , style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontSize: 18.sp,
                    ) ),
                  );
                }
                else if (state is HomeErrorState) {
                  return Center(
                    child: Text(state.error),
                  );
                }
                else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Add new list'),
                  content: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MyFormField(
                          hint: 'Title',
                          controller: titleController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Title must not be empty';
                            }
                          },
                        ),
                        MyFormField(
                          hint: 'Description',
                          controller: descriptionController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Description must not be empty';
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<HomeCubit>().addNewTodoToList(
                            todoListId: listId,
                            name: titleController.text,
                            description: descriptionController.text,
                          );
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Add'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              );
            },
            backgroundColor: AppColors.secondaryColor,
            child: const Icon(
              Icons.add,
              size: 40,
            ),
          );
        },
      ),
    );
  }
}
