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
      height: 120,
      width: 100,
      margin: const EdgeInsets.all(7),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: clr,
        borderRadius: BorderRadius.circular(15),
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
                      ? AppColors.white
                      : Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
