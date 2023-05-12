import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_task/Core/const/screens_Names.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            SvgPicture.asset(
              'assets/images/onboarding_second.svg',
            ),
            Text(
              'Start Manage Your Task With',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontSize: 22,
                  ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Text(
              'Mtodo',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, ScreensNames.register);
              },
              child: const Text('SIGN UP'),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, ScreensNames.login);
              },
              child: RichText(
                text: TextSpan(
                  text: 'Already have an account? ',
                  style: Theme.of(context).textTheme.bodyLarge,
                  children: [
                    TextSpan(
                      text: 'LOGIN',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 12.sp,
                            decoration: TextDecoration.underline,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
    );
  }
}
