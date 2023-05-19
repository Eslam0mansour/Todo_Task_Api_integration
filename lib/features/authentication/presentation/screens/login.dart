import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_task/Core/const/colors.dart';
import 'package:todo_task/Core/const/screens_Names.dart';
import 'package:todo_task/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:todo_task/features/authentication/presentation/cubit/auth_states.dart';
import 'package:todo_task/features/authentication/presentation/widgets/my_form_field.dart';
import 'package:todo_task/features/home/presentation/cubit/home_cubit.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                    'Hello Again!',
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          fontSize: 22.sp,
                        ),
                  ),
                ),
                const SizedBox(
                  height: 2.5,
                ),
                Text(
                  'welcome Back',
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
                        controller: emailController,
                        hint: 'Enter your email',
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
                          else if(value.length < 8){
                            return 'password must be more than 8 characters';
                          }
                          else if(!value.contains(RegExp(r'[A-Z]'))){
                            return 'password must contain at least one capital letter';
                          }
                          else if(!value.contains(RegExp(r'[0-9]'))){
                            return 'password must contain at least one number';
                          }
                          else if(!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))){
                            return 'password must contain at least one special character';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      BlocConsumer<AuthCubit,AuthState>(
                          listener: (context, state) {
                            if (state is RegisterSuccessState) {
                              BlocProvider.of<HomeCubit>(context).getTodoLists();
                              Navigator.pushNamedAndRemoveUntil(
                                  context, ScreensNames.home, (route) => false);
                            }
                            if (state is LoginFailureState) {
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
                          },
                          builder: (context, state) {
                          return ElevatedButton(
                            style: Theme.of(context)
                                .elevatedButtonTheme
                                .style!
                                .copyWith(
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                    AppColors.secondaryColor,
                                  ),
                                  minimumSize: MaterialStateProperty.all<Size>(
                                    const Size(double.infinity, 50),
                                  ),
                                ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                FocusScope.of(context).unfocus();
                                context.read<AuthCubit>().login(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                              }
                            },
                            child: state is LoginLoadingState
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.white,
                                    ),
                                  )
                                : const Text(
                                    'LOG IN',
                            ),
                          );
                        }
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Expanded(
                            child: Divider(
                              color: AppColors.primaryColor,
                              thickness: 0.3,
                              indent: 30,
                              endIndent: 3,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text('or continue with',
                              style: Theme.of(context).textTheme.bodyLarge),
                          const SizedBox(
                            width: 10,
                          ),
                          const Expanded(
                            child: Divider(
                              color: AppColors.primaryColor,
                              thickness: 0.3,
                              indent: 3,
                              endIndent: 30,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                              style: Theme.of(context)
                                  .elevatedButtonTheme
                                  .style!
                                  .copyWith(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      AppColors.white,
                                    ),
                                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                  const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 15,
                                  ),
                                ),
                                  ),
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/google.svg',
                                    height: 30,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Google',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: AppColors.primaryColor,
                                            fontSize: 12.sp,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                              style: Theme.of(context)
                                  .elevatedButtonTheme
                                  .style!
                                  .copyWith(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      const Color(0xFF3B5998),
                                    ),
                                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                  const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 15,
                                  ),
                                ),
                                  ),
                              onPressed: () {},
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/facebook.svg',
                                    height: 30,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Facebook',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: AppColors.white,
                                            fontSize: 12.sp,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Not a member?',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, ScreensNames.register);
                              },
                              child: Text(
                                'Register now',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      color: AppColors.secondaryColor,
                                  fontSize: 12.sp,
                                    ),
                              ),
                            ),
                          ]),
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
