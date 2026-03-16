import 'package:flutter/material.dart';

class Listmodel {
  final Widget icon;
  final String title;
  final String description;

  Listmodel({required this.icon, required this.title, required this.description});

}


List<Listmodel> listIndex =[
  Listmodel(icon: Image.asset('assets/images/dumbbell.png', width: 50, height: 50, color: Colors.white), title: "Practice", description: "Sports, gym, ...etc"),
  Listmodel(icon: Icon(Icons.book_rounded, size: 30, color: Colors.white), title: "Study", description: "Subjects, exams, etc"),
  Listmodel(icon: Icon(Icons.work_outline_rounded, size: 30, color: Colors.white), title: "Work", description: "Work tasks"),
  Listmodel(icon: Icon(Icons.home_work_rounded, size: 30, color: Colors.white), title: "Home", description: "Home tasks"),
];