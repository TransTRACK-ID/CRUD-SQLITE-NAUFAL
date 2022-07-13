import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:crud_final/repositories/base_repositories.dart';
import 'package:crud_final/modules/view/themes.dart';
import 'package:crud_final/models/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TodoCubit()..createDatabase()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: lightTheme,
        darkTheme: darkTheme,
        home: AnimatedSplashScreen(
          splash: Image.asset('assets/images/mytask.png', 
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity),
          nextScreen: const HomeScreen(),
          splashIconSize: double.infinity,
          splashTransition: SplashTransition.fadeTransition,
          pageTransitionType: PageTransitionType.fade,
          backgroundColor: Colors.transparent,
          duration: 3000,
          ),
      ),
    );
  }
}
