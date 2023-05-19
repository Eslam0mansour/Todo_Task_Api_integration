import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_task/Core/const/colors.dart';
import 'package:todo_task/Core/const/screens_Names.dart';
import 'package:todo_task/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:todo_task/features/authentication/presentation/cubit/auth_states.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        width: 60.w,
        backgroundColor: (Theme.of(context).brightness == Brightness.dark)
            ? AppColors.darkBlue
            : const Color(0xFFF6F6F6),
        child: ListView(
          children: [
            DrawerHeader(
              margin: const EdgeInsets.all(0),
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: (Theme.of(context).brightness == Brightness.dark)
                    ? AppColors.darkBlue
                    : const Color(0xFFF6F6F6),
                shape: BoxShape.rectangle,
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        color: AppColors.secondaryColor,
                        size: 40,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: const CircleAvatar(
                          backgroundImage: AssetImage('assets/images/img.png'),
                          backgroundColor: Colors.transparent,
                          radius: 30,
                        ),
                      ),
                      BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text( context.read<AuthCubit>().user!.nameE! ,
                                  style:
                                      Theme.of(context).textTheme.labelLarge),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                context.read<AuthCubit>().user!.emailE! ,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontSize: 8.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SvgPicture.asset(
              'assets/icons/dvider.svg',
            ),
            ListTile(
              leading: SvgPicture.asset(
                'assets/icons/edit.svg',
                height: 30,
              ),
              title: Text('Edit profile',
                  style: Theme.of(context).textTheme.titleMedium!),
              onTap: () {},
            ),
            ListTile(
              leading: SvgPicture.asset(
                'assets/icons/daily.svg',
                height: 30,
              ),
              title: Text('Daily tasks',
                  style: Theme.of(context).textTheme.titleMedium!),
              onTap: () {},
            ),
            ListTile(
              leading: SvgPicture.asset(
                'assets/icons/grey_star.svg',
                height: 30,
              ),
              title: Text('Important tasks',
                  style: Theme.of(context).textTheme.titleMedium!),
              onTap: () {},
            ),
            ListTile(
              leading: SvgPicture.asset(
                'assets/icons/done.svg',
                height: 30,
              ),
              title: Text('Done tasks',
                  style: Theme.of(context).textTheme.titleMedium!),
              onTap: () {},
            ),
            //  log out
            BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
              return ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Theme.of(context).iconTheme.color,
                  size: 30,
                ),
                title: Text('Log out',
                    style: Theme.of(context).textTheme.titleMedium!),
                onTap: () {
                  AuthCubit.get(context).logout();
                },
              );
            }),
          ],
        ));
  }
}
