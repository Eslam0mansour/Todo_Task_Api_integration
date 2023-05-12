import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_task/Core/const/colors.dart';
import 'package:todo_task/Core/const/screens_Names.dart';
import 'package:todo_task/features/auth/widgets/my_form_field.dart';
import 'package:todo_task/features/home/widgets/cubit_button.dart';
import 'package:todo_task/features/home/widgets/mydrawer.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  TextEditingController searchController = TextEditingController();

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
              icon: const Icon(Icons.menu,size: 35, color: AppColors.primaryColor,)
          );
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
      body: Column(
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
                                .copyWith(color: Colors.black, fontSize: 20.sp),
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
                        DateFormat('EEEE,MMMM,d,yyyy').format(DateTime.now()),
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
                GridView.count(
                    padding: const EdgeInsets.all(0.0),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    children: [
                      CubitButton(
                          text: 'School',
                          icon: 'assets/icons/school.svg',
                          function: () {
                            Navigator.pushNamed(context, ScreensNames.todos);
                          },
                          index: 0,
                          clr: const Color(0xff2A8899)),
                      CubitButton(
                          text: 'Work',
                          icon: 'assets/icons/bag.svg',
                          function: () {},
                          index: 2,
                          clr: const Color(0xff5EB0D2)),
                      CubitButton(
                          text: 'Shop',
                          icon: 'assets/icons/cart.svg',
                          function: () {},
                          index: 4,
                          clr: const Color(0xff646FD4)),
                      CubitButton(
                          text: 'Read',
                          icon: 'assets/icons/book.svg',
                          function: () {},
                          index: 3,
                          clr: const Color(0xffBE8972)),
                      CubitButton(
                          text: 'work out',
                          icon: 'assets/icons/run.svg',
                          function: () {},
                          index: 5,
                          clr: const Color(0xff83BC74)),
                      Container(
                        height: 100,
                        width: 100,
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xffD25EB0),
                            width: 2,
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: InkWell(
                          onTap: () {
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(
                                Icons.add,
                                color: Color(0xffD25EB0),
                                size: 50,
                              ),
                            ],
                          ),
                        ),
                      )
                    ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

