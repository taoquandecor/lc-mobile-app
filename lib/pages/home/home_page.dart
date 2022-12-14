import 'package:flutter/material.dart';
import 'package:lcmobileapp/pages/account/profile_page.dart';
import 'package:lcmobileapp/pages/home/main_page2.dart';
import 'package:lcmobileapp/pages/tally/first_weight_page.dart';
import 'package:lcmobileapp/pages/tally/tally_berth_page.dart';
import 'package:lcmobileapp/utils/app_color.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List pages = [
    const MainPage2(),
    const FirstWeightPage(),
    const TallyBerthPage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    var response = Get.arguments;
    if (response == "FirstWeight") {
      _selectedIndex = 1; // tally bốt cân
    } else if (response == "TallyBerth") {
      _selectedIndex = 2; // tally cầu bến
    }
  }

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
            label: "FirstWeight",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.phone_iphone),
            label: "TallyBerth",
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
