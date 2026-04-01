import "package:my_app/cubit/test_cubit.dart";
import "package:my_app/cubit/theme_cubit.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:my_app/sharedpref.dart';
import 'screens/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  runApp(
    MultiBlocProvider(
        providers: [
      BlocProvider(create: (context) => TestCubit()),
      BlocProvider(create: (context) => ThemeCubit()),
    ],
        child: MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder <ThemeCubit, ThemeMode>(
        builder: (context, themeMode) => MaterialApp(
          debugShowCheckedModeBanner: false,
            title: 'Fill my task',
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
                brightness: Brightness.dark,
              ),
            ),
          themeMode: themeMode,
          home: SplashScreen(),
        ),
    );
  }
}



