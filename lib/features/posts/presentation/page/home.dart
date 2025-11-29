import 'package:flutter/material.dart';

import 'home_page.dart';
import 'post_me.dart';
import 'profile_screen.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> screen = [ProfileScreen(), HomePage(), PostsMe()];

  int index = 1;

  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'profile'),
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
    BottomNavigationBarItem(icon: Icon(Icons.post_add_outlined), label: 'post'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        unselectedLabelStyle: TextStyle(color: Colors.black, fontSize: 12),
        selectedLabelStyle: TextStyle(color: Colors.blue, fontSize: 16),
        backgroundColor: Color.fromARGB(255, 201, 199, 199),
        items: items,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        currentIndex: index,
      ),
      body: screen[index],
    );
  }
}
