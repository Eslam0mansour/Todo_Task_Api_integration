import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_task/Core/const/colors.dart';
import 'package:todo_task/Core/const/screens_Names.dart';
import 'package:todo_task/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:todo_task/features/authentication/presentation/cubit/auth_states.dart';
import 'package:todo_task/features/authentication/presentation/widgets/my_form_field.dart';
import 'package:todo_task/features/home/presentation/cubit/home_cubit.dart';

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
          padding: const EdgeInsets.only(top: 30),
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
                          } else if (!value.contains('@')) {
                            return 'Please enter a valid email';
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
                          } else if (value.length < 8) {
                            return 'at least 8 characters';
                          } else if (!value.contains(RegExp(r'[0-9]'))) {
                            return 'at least one number';
                          } else if (!value.contains(RegExp(r'[A-Z]'))) {
                            return 'at least one capital letter';
                          } else if (!value.contains(RegExp(r'[a-z]'))) {
                            return 'at least one small letter';
                          } else if (!value
                              .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                            return 'at least one special character';
                          }
                          return null;
                        },
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'by signing up you agree to our ',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 10.sp,
                                  ),
                          children: [
                            TextSpan(
                              text: 'Terms of service',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontSize: 10.sp,
                                    color: AppColors.thirdColor,
                                  ),
                            ),
                            TextSpan(
                              text: ' and ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontSize: 10.sp,
                                  ),
                            ),
                            TextSpan(
                              text: 'Privacy policy',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
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
                      BlocConsumer<AuthCubit, AuthState>(
                          listener: (context, state) {
                        if (state is RegisterSuccessState) {
                          BlocProvider.of<HomeCubit>(context).getTodoLists();
                          Navigator.pushNamedAndRemoveUntil(
                              context, ScreensNames.home, (route) => false);
                        }
                        if (state is RegisterFailureState) {
                          Fluttertoast.showToast(
                              msg: state.errorMessage,
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: AppColors.primaryColor,
                              textColor: AppColors.white,
                              fontSize: 16.0
                          );
                        }
                      }, builder: (context, state) {
                        return ElevatedButton(
                          style: Theme.of(context)
                              .elevatedButtonTheme
                              .style!
                              .copyWith(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  AppColors.secondaryColor,
                                ),
                                minimumSize: MaterialStateProperty.all<Size>(
                                  const Size(double.infinity, 50),
                                ),
                              ),
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            if (_formKey.currentState!.validate()) {
                              AuthCubit.get(context).register(
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text,
                              );
                            }
                          },
                          child: state is RegisterLoadingState
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  'SIGN UP',
                                ),
                        );
                      }),
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
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
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
