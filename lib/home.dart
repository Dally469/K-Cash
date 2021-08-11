import 'package:flutter/material.dart';
import 'package:kcash/Pages/dashboard.dart';
import 'package:kcash/Pages/services.dart';
import 'package:kcash/Pages/transfer.dart';
import 'package:kcash/utils/colors.dart';
import 'package:kcash/utils/placehoder.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    Dashboard(),
    Transfer(),
    Services(),
    PlaceholderWidget(Colors.orange),
    PlaceholderWidget(Colors.teal)
  ];

  @override
  Widget build(BuildContext context) {
    void onTabTapped(int index) {
      setState(() {
        _currentIndex = index;
      });
    }
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex,
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
            selectedColor: greenColor,
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: Icon(Icons.star),
            title: Text("Transfer"),
            selectedColor: greenColor,
          ),

          SalomonBottomBarItem(
            icon: Icon(Icons.payments),
            title: Text("Buy"),
            selectedColor: greenColor,
          ),


          /// Search
          SalomonBottomBarItem(
            icon: Icon(Icons.account_balance_wallet),
            title: Text("My Wallet"),
            selectedColor: greenColor,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: Icon(Icons.person),
            title: Text("Profile"),
            selectedColor:greenColor,
          ),
        ],
      ),
    );
  }


}
