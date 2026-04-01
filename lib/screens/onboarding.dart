import 'package:flutter/material.dart';
import 'package:my_app/screens/to_do_screen.dart';
import 'package:my_app/on_boarding_model.dart';
import '../sharedPref.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding extends StatefulWidget {
  OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final List<OnBoardingModel> pages = [
    OnBoardingModel(
        image: 'assets/images/welcome.png',
        title: 'Welcome!',
        description: "It's my pleasure to help you on your tasks 😊"),
    OnBoardingModel(
        image: 'assets/images/todo.png',
        title: 'Afraid of forgetting tasks?',
        description:
            "Don't worry 😌\nYou can add many tasks you have, check on them and delete them as you wish."),
    OnBoardingModel(
        image: 'assets/images/start.png',
        title: 'What are you waiting for? 🤔',
        description: "Let's do our first task!"),
  ];

  int currentIndex = 0;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: PageView.builder(
              itemCount: pages.length,
              controller: pageController,
              onPageChanged: (value) {
                setState(() {
                  currentIndex = value;
                });
              },
              itemBuilder: (context, index) {
                final page = pages[index];
                return Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(page.image,
                          fit: BoxFit.cover, height: 250, width: 250),
                      const SizedBox(height: 70),
                      Text(page.title,
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      const SizedBox(height: 20),
                      Text(page.description, textAlign: TextAlign.center),
                      const SizedBox(height: 70),
                      SmoothPageIndicator(
                          effect: ExpandingDotsEffect(
                            activeDotColor: Colors.blue,
                            dotColor: Colors.grey,
                          ),
                          controller: pageController,
                          count: pages.length),
                      const SizedBox(height: 70),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (currentIndex == 0) {
                                CacheHelper.setData(key: 'onBoarding', value: true);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ToDoScreen()));
                              } else {
                                pageController.previousPage(
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.ease);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                            child: Text(
                              currentIndex == 0 ? 'Skip' : 'Back',
                              style: TextStyle(color: Colors.blue[800]),
                            ),
                          ),
                          const SizedBox(width: 20),
                          ElevatedButton(
                            onPressed: () {
                              if (currentIndex == pages.length - 1) {
                                CacheHelper.setData(key: 'onBoarding', value: true);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ToDoScreen()));
                              } else {
                                pageController.nextPage(
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.ease);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                            child: Text(
                                currentIndex == pages.length - 1
                                    ? 'Get Started'
                                    : 'Next',
                                style: TextStyle(color: Colors.blue[800])),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }),
        )
      ],
    )
    );
  }
}
