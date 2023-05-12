//Container cubitButton({
//   context,
//   String? text,
//   String? icon,
//   void Function()? function,
//   int? index,
//   Color? clr,
//   Color? iconColor,
// }) =>

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_task/Core/const/colors.dart';

class CubitButton extends StatelessWidget {
  String? text;
  String? icon;
  void Function()? function;
  int? index;
  Color? clr;
  Color? iconColor;

  CubitButton({
    Key? key,
    this.text,
    this.icon,
    this.function,
    this.index,
    this.clr,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: clr,
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: function,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Text(
                index.toString(),
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.white,
                      fontSize: 10.sp,
                    ),
              ),
            ),
            SvgPicture.asset(icon!,
                color: (Theme.of(context).brightness == Brightness.dark)
                    ? AppColors.darkBlue
                    : Colors.white),
            const SizedBox(
              height: 10,
            ),
            Text(
              text!,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: (Theme.of(context).brightness == Brightness.dark)
                      ? AppColors.darkBlue
                      : Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
