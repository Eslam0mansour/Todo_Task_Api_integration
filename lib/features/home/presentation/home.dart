import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_task/Core/const/colors.dart';
import 'package:todo_task/Core/const/screens_Names.dart';
import 'package:todo_task/features/auth/widgets/my_form_field.dart';
import 'package:todo_task/features/home/cubit/home_cubit.dart';
import 'package:todo_task/features/home/cubit/home_staets.dart';
import 'package:todo_task/features/home/widgets/cubit_button.dart';
import 'package:todo_task/features/home/widgets/mydrawer.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  TextEditingController searchController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController iconController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Container buildContainer(context, String text) => Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: (Theme.of(context).brightness == Brightness.dark)
              ? Colors.grey[900]
              : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: (Theme.of(context).brightness == Brightness.dark)
                ? Colors.grey[600]!
                : AppColors.primaryColor,
            width: 1.2,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: (Theme.of(context).brightness == Brightness.dark)
                    ? Colors.white
                    : Colors.grey[700],
                fontSize: 13.sp,
                fontWeight: FontWeight.w400),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: MyDrawer(),
      drawerEdgeDragWidth: MediaQuery.of(context).size.width * 0.3,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(builder: (context) {
          return IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(
                Icons.menu,
                size: 35,
                color: AppColors.primaryColor,
              ));
        }),
        centerTitle: true,
        title: Text(
          'Mtodo Logo',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Colors.white,
              ),
        ),
        actions: const [
          CircleAvatar(
            foregroundImage: AssetImage('assets/images/img.png'),
            backgroundColor: Colors.transparent,
            radius: 30,
          ),
        ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    SvgPicture.asset(
                      'assets/images/home.svg',
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.42,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      bottom: 30,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RichText(
                              text: TextSpan(
                                  text: 'you have ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                          color: Colors.black, fontSize: 20.sp),
                                  children: [
                                    TextSpan(
                                      text: '5 tasks ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall!
                                          .copyWith(
                                              color: Colors.white,
                                              fontSize: 22.sp,
                                              fontWeight: FontWeight.w600),
                                    ),
                                    const TextSpan(
                                      text: 'today!',
                                    ),
                                  ]),
                            ),
                            Text(
                              DateFormat('EEEE,MMMM,d,yyyy')
                                  .format(DateTime.now()),
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                      color: Colors.black,
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w500),
                            ),
                            MyFormField(
                              hint: 'Search tasks',
                              controller: searchController,
                              // hintStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
                              //   color: Colors.grey,
                              //   fontSize: 14.sp,
                              //   fontWeight: FontWeight.w300
                              // ),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.grey,
                                size: 30,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 5,
                    right: 5,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            //  today week month
                            Expanded(
                              child: buildContainer(context, 'Today'),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Expanded(
                              child: buildContainer(context, 'Week'),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Expanded(
                              child: buildContainer(context, 'Month'),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      state is HomeLoadingState
                          ? const CircularProgressIndicator()
                          : GridView.builder(
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(0.0),
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: context
                                  .read<HomeCubit>()
                                  .listsOfTodoLists
                                  .length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 1.0,
                                mainAxisSpacing: 2.0,
                                crossAxisSpacing: 2.0,
                              ),
                              itemBuilder: (context, index) {
                                return CubitButton(
                                    text: context
                                        .read<HomeCubit>()
                                        .listsOfTodoLists[index]
                                        .title,
                                    icon: context
                                        .read<HomeCubit>()
                                        .listsOfTodoLists[index]
                                        .icon,
                                    function: () {
                                      context.read<HomeCubit>().getTodoListById(
                                          id: context
                                              .read<HomeCubit>()
                                              .listsOfTodoLists[index]
                                              .id!);
                                      Navigator.pushNamed(
                                          context, ScreensNames.todos,
                                          arguments: context
                                              .read<HomeCubit>()
                                              .listsOfTodoLists[index]
                                              .id);
                                    },
                                    index: context
                                        .read<HomeCubit>()
                                        .listsOfTodoLists[index]
                                        .todosCount,
                                    clr: const Color(0xff2A8899));
                              },
                            ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
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
                  title: Text(
                    'Add new list',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontSize: 20.sp, fontWeight: FontWeight.w600),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  content: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          MyFormField(
                            hint: 'Title',
                            controller: titleController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'title must not be empty';
                              }
                            },
                          ),
                          MyFormField(
                            hint: 'Description',
                            controller: descriptionController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'description must not be empty';
                              }
                            },
                          ),
                          DropdownButtonFormField<String>(
                            validator: (value) {
                              if (value == null) {
                                return 'icon must not be empty';
                              }
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: 'Icon',
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w300),
                            ),
                            items: [
                              DropdownMenuItem(
                                value: 'assets/icons/school.svg',
                                child: Row(
                                  children: [
                                    SvgPicture.asset('assets/icons/school.svg',
                                        color: Colors.black),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text('School'),
                                  ],
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'assets/icons/bag.svg',
                                child: Row(
                                  children: [
                                    SvgPicture.asset('assets/icons/bag.svg',
                                        color: Colors.black),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text('Bag'),
                                  ],
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'assets/icons/cart.svg',
                                child: Row(
                                  children: [
                                    SvgPicture.asset('assets/icons/cart.svg',
                                        color: Colors.black),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text('Cart'),
                                  ],
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'assets/icons/book.svg',
                                child: Row(
                                  children: [
                                    SvgPicture.asset('assets/icons/book.svg',
                                        color: Colors.black),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text('Book'),
                                  ],
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'assets/icons/run.svg',
                                child: Row(
                                  children: [
                                    SvgPicture.asset('assets/icons/run.svg',
                                        color: Colors.black),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text('Run'),
                                  ],
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'assets/icons/done.svg',
                                child: Row(
                                  children: [
                                    SvgPicture.asset('assets/icons/done.svg',
                                        color: Colors.black),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text('Done'),
                                  ],
                                ),
                              ),
                            ],
                            onChanged: (value) {
                              iconController.text = value!;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<HomeCubit>().addNewTodoList(
                            title: titleController.text,
                            description: descriptionController.text,
                            icon: iconController.text,
                          );
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Add'),
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
