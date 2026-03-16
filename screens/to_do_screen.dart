import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/cubit/theme_cubit.dart';
import 'package:my_app/fields/StudyField.dart';
import 'package:my_app/fields/homeField.dart';
import 'package:my_app/fields/practiceField.dart';
import 'package:my_app/fields/workField.dart';
import 'package:my_app/models/listModel.dart';
import 'package:my_app/sharedPref.dart';

class ToDoScreen extends StatefulWidget {
   ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  int currentIndex = 0;
  List routings = [
    PracticeField(),
    StudyField(),
    WorkField(),
    HomeField(),
  ];


  @override
  void dispose() {
    super.dispose();
    CacheHelper.getData(key: 'theme');
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Lists",
          style: TextStyle(fontSize: 40, fontFamily: 'Dancing'),
        ),
        centerTitle: true,
        leading: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            bool isDark = themeMode == ThemeMode.light;
            return IconButton(
              onPressed: () {
                context.read<ThemeCubit>().toggleTheme(isDark);
              },
              icon: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Expanded(
              child: GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemCount: listIndex.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return ElevatedButton(
                      onPressed: () {
                        setState(() {
                          currentIndex = index;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => routings[index]));
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.grey,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.blue,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          listIndex[index].icon,
                          const SizedBox(height: 10),
                          Text(
                            listIndex[index].title,
                            style: const TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            listIndex[index].description,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
