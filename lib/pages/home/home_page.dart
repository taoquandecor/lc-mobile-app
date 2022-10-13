import 'package:flutter/material.dart';
import 'package:lcmobileapp/pages/account/profile_page.dart';
import 'package:lcmobileapp/pages/home/main_page.dart';
import 'package:lcmobileapp/pages/tally/first_weight_page.dart';
import 'package:lcmobileapp/utils/app_color.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List pages = [
    MainPage(),
    FirstWeightPage(),
    Container(
      child: Center(child: Text("Next next page")),
    ),
    ProfilePage(),
  ];
  void onTapNav(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColor.mainColor,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,
        currentIndex: _selectedIndex,
        onTap: onTapNav,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.phone_iphone),
            label: "Tally",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Person",
          )
        ],
      ),
    );
  }
}
