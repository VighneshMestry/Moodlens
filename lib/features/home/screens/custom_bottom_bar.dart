import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loc_hackathon/features/home/screens/demo_screen.dart';
import 'package:loc_hackathon/features/home/screens/home_screen.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({super.key});

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
   int _page = 0;

  void onPageChange(int page) {
    setState(() {
      _page = page;
    });
  }

  static const tabWidgets = [
    HomeScreen(),
    DemoScreen(),
    DemoScreen(),
    DemoScreen(),
    DemoScreen(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabWidgets[_page],
      bottomNavigationBar: CupertinoTabBar(
        height: 60,
        border: const Border(top: BorderSide.none),
        activeColor: Colors.black,
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insights_rounded),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
        onTap: onPageChange,
        currentIndex: _page,
      ),
    );
  }
}