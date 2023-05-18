import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_task/Core/const/screens_Names.dart';

class OnBoardingIntro extends StatelessWidget {
  const OnBoardingIntro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/onboarding_intro.svg',
              height: MediaQuery.of(context).size.height * 0.5,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Text(
              'Manage your tasks',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Text(
              'organize, plan, and collaborate on tasks with\nMtodo.Your busy life deserves this.you can manage checklist and your goal. ',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, ScreensNames.onBoarding);
              },
              child: const Text('Get Started',),
            ),
          ]),
    );
  }
}
