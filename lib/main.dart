import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_task/Core/const/screens_Names.dart';
import 'package:todo_task/Core/di/di.dart';
import 'package:todo_task/Core/observer/BlocObserver.dart';
import 'package:todo_task/Core/router/app_router.dart';
import 'package:todo_task/Core/services/local/my_shared_preferences.dart';
import 'package:todo_task/Core/styles/theme.dart';
import 'package:todo_task/features/auth/cubit/auth_cubit.dart';
import 'package:todo_task/features/auth/cubit/auth_states.dart';
import 'package:todo_task/features/home/cubit/home_cubit.dart';
//a
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  init();
  await sl<MySharedPref>().initSP();

  runApp(Phoenix(
    child: MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit()..init(),
        ),
        BlocProvider<HomeCubit>(
          create: (context) => HomeCubit()..getTodoLists(),
        ),
      ],
      child: MyApp.create(),
    ),
  ));
}

final _navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static Widget create() {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is NotHaveCurrentUser) {
          Future.delayed(const Duration(seconds: 1), () {
            _navigatorKey.currentState?.pushNamedAndRemoveUntil(
                ScreensNames.login, (r) => false);
          });
        }
        if (state is HaveCurrentUser) {
          Future.delayed(const Duration(seconds: 1), () {
            _navigatorKey.currentState
                ?.pushNamedAndRemoveUntil(ScreensNames.home, (r) => false);
          });
        }
        if (state is NoInternetConnection) {
          Future.delayed(const Duration(seconds: 3), () {
            _navigatorKey.currentState?.pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const NoInternet()),
                (r) => false);
          });
        }
      },
      child: const MyApp(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        navigatorKey: _navigatorKey,
        onGenerateRoute: sl<AppRouter>().onGenerateRoute
      );
    });
  }
}

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.teal,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Todos',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          ],
        ));
  }
}

class NoInternet extends StatefulWidget {
  const NoInternet({Key? key}) : super(key: key);

  @override
  State<NoInternet> createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('يرجي التحقق من الاتصال بالانترنت'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text(
            'يرجي التحقق من الاتصال بالانترنت \n ثم اعد المحاولة',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                Phoenix.rebirth(context);
              },
              child: const Text('اعد المحاولة الان'),
            ),
          ),
        ],
      ),
    );
  }
}
