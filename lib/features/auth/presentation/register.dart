import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_task/Core/const/colors.dart';
import 'package:todo_task/Core/const/screens_Names.dart';
import 'package:todo_task/features/auth/widgets/my_form_field.dart';

class Register extends StatelessWidget {
  Register({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Mtodo Logo',
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontSize: 18.sp,
              ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
         padding: const EdgeInsets.only(
            top: 30
         ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'Hello!',
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          fontSize: 22.sp,
                        ),
                  ),
                ),
                const SizedBox(
                  height: 2.5,
                ),
                Text(
                  ' welcome to Mtodo app\nsign up to get started.',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontSize: 14.sp,
                        color: AppColors.thirdColor2,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      MyFormField(
                        controller: nameController,
                        hint: 'your name',
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      MyFormField(
                        controller: emailController,
                        hint: 'Enter email',
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      MyFormField(
                        controller: passwordController,
                        hint: 'password',
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'by signing up you agree to our ',
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                fontSize: 10.sp,
                              ),
                          children: [
                            TextSpan(
                              text: 'Terms of service',
                              style:
                                  Theme.of(context).textTheme.bodyLarge!.copyWith(
                                        fontSize: 10.sp,
                                        color: AppColors.thirdColor,
                                      ),
                            ),
                            TextSpan(
                              text: ' and ',
                              style:
                                  Theme.of(context).textTheme.bodyLarge!.copyWith(
                                        fontSize: 10.sp,
                                      ),
                            ),
                            TextSpan(
                              text: 'Privacy policy',
                              style:
                                  Theme.of(context).textTheme.bodyLarge!.copyWith(
                                        fontSize: 10.sp,
                                        color: AppColors.thirdColor,
                                      ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      ElevatedButton(
                        style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            AppColors.secondaryColor,
                            ),
                          minimumSize: MaterialStateProperty.all<Size>(
                            const Size(double.infinity, 50),
                            ),
                        ),
                        onPressed: () {},
                        child: const Text('SIGN UP'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
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
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
